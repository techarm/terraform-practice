module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.3"

  project_id   = var.gcp_project
  network_name = "${local.name}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${local.name}-${var.gcp_region}-subnet"
      subnet_ip     = "10.128.0.0/20"
      subnet_region = var.gcp_region
    }
  ]
}
