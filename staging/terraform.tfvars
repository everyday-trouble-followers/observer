### common
basename = "observer"


### network
vpc_cidr_block = "10.0.0.0/16"
sn_names = [
  "1"
]


### firewall
ingress_management_ports = {
  "ssh" : 22,
  "http" : 80,
  "https" : 443,
}
# ingress_management_cidr_blocks is set to ip.tfvars
ingress_function_ports = {
  "elasticsearch" : 9200,
  "apm" : 8200,
}
# ingress_function_cidr_blocks is set to ip.tfvars.


### key pair
key_file_path = "~/.ssh/"


### ec2
template_file_path = "./modules/ec2/template_files/"

## kibana
kibana_counts = 1
instance_type_kibana = "t3.medium"
volume_size_kibana = 15

## elasticsearch
elasticsearch_counts = 1
instance_type_elasticsearch = "t3.large"
volume_size_elasticsearch = 50

## apm
apm_counts = 1
instance_type_apm = "t3.medium"
volume_size_apm = 15

### config
elastic_version = "7.10.2"

## kibana
kibana_server_port = 80
kibana_server_host = "0.0.0.0"
kibana_server_name = "kibana"

## elasticsearch
elasticsearch_jvm_Xms = "4g"
elasticsearch_jvm_Xmx = "4g"
elasticsearch_node_name = "$${HOSTNAME}"
elasticsearch_network_host = [ "0.0.0.0" ]
elasticsearch_http_port = 9200

## apm
apm_server_host = "0.0.0.0:8200"


### route53
domain_name = "sub.example.com"