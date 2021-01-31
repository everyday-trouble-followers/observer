provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_default_region
}

module "network" {
  source         = "./modules/network/"
  basename       = var.basename
  vpc_cidr_block = var.vpc_cidr_block
  sn_names       = var.sn_names
}
