module "database" {
  source = "./modules/rds"

  project_name       = "project04-rds-modules"
  security_group_ids = []
  subnet_ids         = []
  credentials = {
    username = "dbadmin"
    password = "P@ssw0rd123"
  }
}
