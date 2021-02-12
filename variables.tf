###################################################################
# Please set access_key_id, secret_access_key and default region  #
# as environment variables prefixed with "TF_VARS_".              #
# For example, TF_VAR_aws_access_key_id = AKIA********.           #
###################################################################

### environment variables
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_default_region" {}

### common
variable "basename" {
  type        = string
  description = "this project basename."
  default     = "project"
}

### network
variable "vpc_cidr_block" {}
variable "sn_names" {}


### firewall
variable "ingress_management_ports" {}
variable "ingress_management_cidr_blocks" {}
variable "ingress_function_ports" {}
variable "ingress_function_cidr_blocks" {}


### key pair
variable "key_file_path" {}


### ec2
variable "template_file_path" {}

## kibana
variable "kibana_counts" {}
variable "instance_type_kibana" {}
variable "volume_size_kibana" {}

## elasticsearch
variable "elasticsearch_counts" {}
variable "instance_type_elasticsearch" {}
variable "volume_size_elasticsearch" {}

## apm
variable "apm_counts" {}
variable "instance_type_apm" {}
variable "volume_size_apm" {}

### config
variable "elastic_version" {}

## kibana
variable "kibana_server_port" {}
variable "kibana_server_host" {}
variable "kibana_server_name" {}

## elasticsearch
variable "elasticsearch_jvm_Xms" {}
variable "elasticsearch_jvm_Xmx" {}
variable "elasticsearch_node_name" {}
variable "elasticsearch_network_host" {}
variable "elasticsearch_http_port" {}

## apm
variable "apm_server_host" {}


### route53
variable "domain_name" {}
