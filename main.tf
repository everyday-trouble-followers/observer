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

module "firewall" {
  source                         = "./modules/firewall/"
  basename                       = var.basename
  vpc_id                         = module.network.vpc_id
  ingress_management_ports       = var.ingress_management_ports
  ingress_management_cidr_blocks = var.ingress_management_cidr_blocks
  ingress_function_ports         = var.ingress_function_ports
  ingress_function_cidr_blocks   = var.ingress_function_cidr_blocks
}
