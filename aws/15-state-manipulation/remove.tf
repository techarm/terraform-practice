/**
1. Remove via CLI
2. Remove via the remote block
*/

removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = true
  }
}

# 登録後、コメントアウトにより削除される
# resource "aws_s3_bucket" "my_new_bucket" {
#   bucket = "random-name-20240622abc"
# }
