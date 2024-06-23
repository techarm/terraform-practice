output "rds_info" {
  value = {
    "arn" : module.database.rds_instance_arn
    "id" : module.database.rds_instance_id
    "address" : module.database.rds_instance_address
    "port" : module.database.rds_instance_port
    "endpoint" : module.database.rds_instance_endpoint
  }
}
