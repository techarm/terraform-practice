module "database" {
  source = "./modules/rds"

  project_name = "project04-rds-modules"
  security_group_ids = [
    aws_security_group.compliant.id
  ]
  subnet_ids = [
    aws_subnet.allowed.id,
    aws_subnet.allowed2.id
  ]
  credentials = {
    username = "dbadmin"
    password = "Passw0rd123"
  }
}
