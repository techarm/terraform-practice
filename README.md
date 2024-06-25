# Terraform の基本操作

## リストのループ

```hcl
locals {
  double_number = [for num in var.number_list : num * 2]
  event_number  = [for num in var.number_list : num if num % 2 == 0]
  names         = [for person in var.object_list : person.name]
  persons       = [for person in var.object_list : "name: ${person.name}, age: ${person.age}"]
}
```

## リストオブジェクトのアクセス

```hcl
locals {
  name_from_splat  = var.object_list[*].name # リスト内でのみ使用、mapでは機能しない
  map_keys_splat   = keys(var.number_map)
  map_values_splat = values(var.number_map)
}
```

## map のループ

```hcl
locals {
  double_map = { for key, value in var.number_map : upper(key) => "${value}: ${key}" }
}

locals {
  user_info_map = { for user in var.users : user.username => user.role... } # 複数のキーが存在する場合、値はリストになる
}
```

## 関数

Terraform は多くの組み込み関数をサポートしていますが、カスタム関数はまだサポートされていません。詳細は[公式ドキュメント](https://developer.hashicorp.com/terraform/language/functions)を参照してください。

## オブジェクトのバリデーション

### precondition

```hcl
lifecycle {
  precondition {
    condition     = ...
    error_message = "..."
  }
}
```

- リソースおよびデータブロック内で使用
- リソース自体を参照することはできません
- データブロックや変数の有効性をチェックするために使用

### postcondition

```hcl
lifecycle {
  postcondition {
    condition     = ...
    error_message = "..."
  }
}
```

- リソースおよびデータブロック内で使用
- リソース自体を参照することができます
- リソースの構成の有効性をチェックするために使用

### アサーションのチェック

```hcl
check "my_custom_check" {
  assertion {
    condition     = ...
    error_message = "..."
  }
}
```

- リソースおよびデータブロックの外部から使用
- 現在の Terraform プロジェクト全体の情報を参照することができます
- 警告を生成するだけで、適用プロセスを停止しません

## 状態の操作

### mv

リソースを作成した後、リソースの名前を変更するとリソースが削除され、新しいリソースが作成されます。

```hcl
# 旧リソース
resource "aws_instance" "default" {}

# 新リソース
resource "aws_instance" "new_name" {}
```

これを解決するために以下のコマンドを使用できます。

```sh
# 試しに実行
$ terraform state mv -dry-run aws_instance.default aws_instance.new_name
Would move "aws_instance.default" to "aws_instance.new_name"

# 本当に実行
$ terraform state mv aws_instance.default aws_instance.new_name
Would move "aws_instance.default" to "aws_instance.new_name"
```

コードを使用して操作することもできます（コード上に履歴を残せる）。

```hcl
moved {
  from = aws_instance.default
  to   = aws_instance.new_name
}
```

### import

既に作成されたが Terraform で管理されていないリソースを import でインポートできます。コマンドラインと import ブロックでインポートできます。
コマンドライン: `terraform import aws_s3_bucket.remote_state "terraform-course-remote-state-backend"`

```hcl
# CLI
# terraform import aws_s3_bucket.remote_state "terraform-course-remote-state-backend"
resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-course-remote-state-backend"

  tags = {
    Managed   = "Terraform"
    Lifecycle = "Critical"
  }

  lifecycle {
    prevent_destroy = true
  }
}

import {
  id = aws_s3_bucket.remote_state.bucket
  to = aws_s3_bucket_public_access_block.remote_state
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public acls      = true
  restrict_public_buckets = true
}
```

Plan: 1 to import, 0 to add, 0 to change, 0 to destroy.

### remove

Terraform で作成したリソースを Terraform 管理外にしたい場合、コマンドラインやコードで制御できます。

```hcl
removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = true
  }
}
```

### taint

リソースを更新するためにリソースに taint を付けることができます。

```sh
terraform apply -replace="aws_s3_bucket.tainted”
```

このコマンドもリソースを更新するために使用できます。

## ワークスペース

ワークスペースを使用して Terraform state の状態を分けて管理できます。

```sh
Usage: terraform [global options] workspace

  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace
```

コード内で `terraform.workspace` を使用して現在のワークスペース名を参照できます。

### .tfvars を使用してワークスペースの設定を管理

```hcl
# variables.tf
variable "s3_count" {
  type        = number
  description = "The number of s3 bucket"
}

# dev.tfvars
s3_count = 1

# prod.tfvars
s3_count = 2
```

対応するワークスペースに切り替え、設定ファイルをインポートして操作を実行します。

```sh
terraform workspace select dev
terraform apply -var-file=$(terraform workspace show).tfvars
terraform destroy -var-file=$(terraform workspace show).tfvars
```

## よく使うコマンド

1. `terraform init`: 初期化、依存ファイルインストール
   - `terraform init -migrate-state` : リモート state ファイルパス変更時に実行する
2. `terraform plan`: 試し実行
   - `terraform plan -out myplan`: 試し実行をファイルに出力
   - `terraform plan -destroy`
3. `terraform apply`: 内容を反映、確認あり
   - `terraform apply myplan`: 実行プランファイルの内容を適用、その場合は実行確認しない
   - `terraform apply -destroy`
   - `terraform apply —auto-approve`: 確認なし
4. `terraform destroy`: 管理している内容を全部削除
5. `terraform status list`: 現在ステータス情報を表示
6. `terraform output`: output の定義情報を表示
7. `terraform show`: state の内容を表示
   - `terraform show myplan`: プランファイル内容を表示

## バックエンド

- ローカル: ステートファイルがユーザーのローカルマシンに保存される。
- Terraform Cloud: ステートファイルが Terraform Cloud に保存され、追加機能が提供される。
- サードパーティのリモートバックエンド: ステートは Terraform Cloud 以外のリモートバックエンドに保存される（例: S3、Google Cloud Storage、Azure Resource Manager / Blob Storage など）。

各環境にバックエンドの設定ファイルを用意することができます。開発環境と本番環境の設定ファイルを用意後、以下のコマンドを実行します。

```sh
terraform init -backend-config="dev.s3.tfbackend" -migrate-state
```

```hcl
# dev.s3.tfbackend
bucket = "terraform-course-remote-state-backend"
key    = "04-backends/dev/state.tfstate"
region = "ap-northeast-3"

# prod.s3.tfbackend
bucket = "terraform-course-remote-state-backend"
key    = "04-backends/prod/state.tfstate"
region = "ap-northeast-3"
```

```hcl
providers.tf
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {}
}
```

## リソースとデータソース

- **リソース**: 作成する必要があるリソースを定義
- **データソース**: 既存のリソース

情報を取得するために使用される（例: aws_ami、aws_caller_identity、aws_region、aws_vpc、aws_availability_zones、aws_iam_policy_document）

## 入力変数

変数定義の優先順位（高から低）

- 変数のデフォルト値
- 環境変数: `TF_VAR`
- `terraform.tfvars` ファイル
- `terraform.tfvars.json`
- `*.auto.tfvars` または `*auto.tfvars.json`
- コマンドライン `-var` および `-var-file`: `-var` および `-var-file` cli 引数、後者が最優先

## 式

算数表現

```hcl
locals {
  math       = 2 * 2         # 算数演算子: *, /, +, -, -<number>
  equality   = 2 != 2        # 等価演算子: ==, !=
  comparison = 2 < 1         # 比較演算子: >, <, >=, <=
  logical    = true && false # 論理演算子: && (and), || (or)
}
```
