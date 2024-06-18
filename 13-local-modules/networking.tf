module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    name       = "13-local-modules"
    cidr_block = "10.0.0.0/24"
  }
}
