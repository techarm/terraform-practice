module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    name       = "13-local-modules"
    cidr_block = "10.0.0.0/16"
  }
  subnet_config = {
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-northeast-3a"
      public     = true
    }
    private_subnet = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-northeast-3a"
    }
  }
}
