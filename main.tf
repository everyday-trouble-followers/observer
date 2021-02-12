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

module "key_pair" {
  source        = "./modules/key_pair/"
  basename      = var.basename
  key_file_path = var.key_file_path
}

module "ec2" {
  source             = "./modules/ec2/"
  basename           = var.basename
  key_name           = module.key_pair.key_name
  template_file_path = var.template_file_path

  # route53
  domain_name = var.domain_name

  # kibana
  kibana_counts             = var.kibana_counts
  instance_type_kibana      = var.instance_type_kibana
  security_group_ids_kibana = [module.firewall.sg_id]
  subnet_id_kibana          = element(module.network.subnet_id, 0)
  volume_size_kibana        = var.volume_size_kibana

  # elasticsearch
  elasticsearch_counts             = var.elasticsearch_counts
  instance_type_elasticsearch      = var.instance_type_elasticsearch
  security_group_ids_elasticsearch = [module.firewall.sg_id]
  subnet_id_elasticsearch          = element(module.network.subnet_id, 0)
  volume_size_elasticsearch        = var.volume_size_elasticsearch

  # apm
  apm_counts             = var.apm_counts
  instance_type_apm      = var.instance_type_apm
  security_group_ids_apm = [module.firewall.sg_id]
  subnet_id_apm          = element(module.network.subnet_id, 0)
  volume_size_apm        = var.volume_size_apm

  # config
  elastic_version = var.elastic_version

  # kibana
  kibana_server_port = var.kibana_server_port
  kibana_server_host = var.kibana_server_host
  kibana_server_name = var.kibana_server_name

  # elasticsearch
  elasticsearch_jvm_Xms      = var.elasticsearch_jvm_Xms
  elasticsearch_jvm_Xmx      = var.elasticsearch_jvm_Xmx
  elasticsearch_node_name    = var.elasticsearch_node_name
  elasticsearch_network_host = var.elasticsearch_network_host
  elasticsearch_http_port    = var.elasticsearch_http_port

  # elasticsearch
  apm_server_host = var.apm_server_host

}

module "route53" {
  source                   = "./modules/route53/"
  basename                 = var.basename
  domain_name              = var.domain_name
  vpc_id                   = module.network.vpc_id
  kibana_counts            = var.kibana_counts
  kibana_private_ip        = module.ec2.kibana_private_ip
  elasticsearch_counts     = var.elasticsearch_counts
  elasticsearch_private_ip = module.ec2.elasticsearch_private_ip
  apm_counts               = var.apm_counts
  apm_private_ip           = module.ec2.apm_private_ip
}
