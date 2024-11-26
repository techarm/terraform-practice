# Terraform Remote State Datasource - Remote Backend GCP Cloud Storage Bucket
data "terraform_remote_state" "project_db" {
  backend = "gcs"
  config = {
    bucket = "gcplearn-tfstate"
    prefix = "cloudsql/privatedb"
  }
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.terraform_remote_state.project_db.outputs.vpc_id
}

output "mysubnet_id" {
  description = "Subnet ID"
  value       = data.terraform_remote_state.project_db.outputs.mysubnet_id
}

output "cloudsql_privatedb" {
  value = data.terraform_remote_state.project_db.outputs.cloudsql_db_private_ip
}
