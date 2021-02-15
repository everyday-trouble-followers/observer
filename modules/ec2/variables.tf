### common
variable "basename" {}

### route53
variable "domain_name" {}

### ec2
variable "key_name" {
  type        = string
  description = "key name for ssh."
}

variable "template_file_path" {
  type        = string
  description = "template file path."
  default     = "./modules/ec2/template_files"
}

## kibana
variable "kibana_counts" {
  type        = number
  description = "number of kibana units"
  default     = 1
}

variable "instance_type_kibana" {
  type        = string
  description = "instance type for kibana"
  default     = "t3.medium"
}

variable "security_group_ids_kibana" {
  type        = list(string)
  description = "security group for kibana"
}

variable "subnet_id_kibana" {
  type        = string
  description = "subnet id for kibana"
}

variable "volume_size_kibana" {
  type        = number
  description = "volume size for kibana"
  default     = 15
}

## elasticsearch
variable "elasticsearch_counts" {
  type        = number
  description = "number of elasticsearch units"
  default     = 1
}

variable "instance_type_elasticsearch" {
  type        = string
  description = "instance type for elasticsearch"
  default     = "t3.large"
}

variable "security_group_ids_elasticsearch" {
  type        = list(string)
  description = "security group for elasticsearch"
}

variable "subnet_id_elasticsearch" {
  type        = string
  description = "subnet id for elasticsearch"
}

variable "volume_size_elasticsearch" {
  type        = number
  description = "volume size for elasticsearch"
  default     = 50
}

## apm
variable "apm_counts" {
  type        = number
  description = "number of apm units"
  default     = 1
}

variable "instance_type_apm" {
  type        = string
  description = "instance type for apm"
  default     = "t3.medium"
}

variable "security_group_ids_apm" {
  type        = list(string)
  description = "security group for apm"
}

variable "subnet_id_apm" {
  type        = string
  description = "subnet id for apm"
}

variable "volume_size_apm" {
  type        = number
  description = "volume size for apm"
  default     = 15
}

### config
variable "elastic_version" {
  type        = string
  description = "elastic stack version."
  default     = "7.10.2"
}

## kibana
variable "kibana_server_port" {
  type        = number
  description = "kibana server port."
  default     = 80
}

variable "kibana_server_host" {
  type        = string
  description = "kibana server host."
  default     = "localhost"
}

variable "kibana_server_name" {
  type        = string
  description = "kibana server name."
  default     = "kibana"
}

variable "kibana_elasticsearch_hosts" {
  type        = list(string)
  description = "elastisearch hosts."
  default     = [""]
}

## elasticsearch

variable "elasticsearch_jvm_Xms" {
  type        = string
  description = "elasticsearch jvm Xms"
  default     = "4g"
}

variable "elasticsearch_jvm_Xmx" {
  type        = string
  description = "elasticsearch jvm Xmx"
  default     = "4g"
}

# variable "elasticsearch_node_name" {
#   type        = string
#   description = "elasticsearch node name"
#   default     = "elasticsearch"
# }

variable "elasticsearch_network_host" {
  type        = list(string)
  description = "elasticsearch network host. set like lists. [ 'example.com', '192.168.10.1' ]"
  default     = ["example.com", "192.168.10.1"]
}

variable "elasticsearch_http_port" {
  type        = number
  description = "elasticsearch jvm Xmx"
  default     = 9200
}

variable "elasticsearch_discovery_seed_hosts" {
  type        = list(string)
  description = "elasticsearch jvm Xmx"
  default     = [""]
}

variable "elasticsearch_cluster_initial_master_nodes" {
  type        = list(string)
  description = "elasticsearch jvm Xmx"
  default     = [""]
}

## apm
variable "apm_server_host" {
  type        = string
  description = "elasticsearch jvm Xmx"
  default     = "4g"
}

variable "apm_output_elasticsearch_hosts" {
  type        = list(string)
  description = "elasticsearch jvm Xmx"
  default     = [""]
}
