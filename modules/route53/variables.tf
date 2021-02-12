### common
variable "basename" {}

### route53
variable "domain_name" {
  type        = string
  description = "route53 domain name"
  default     = "sub.example.com"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "kibana_counts" {
  type        = number
  description = "number of kibana units"
  default     = 1
}

variable "kibana_private_ip" {
  type        = list(string)
  description = "kibana private ip"
}

variable "elasticsearch_counts" {
  type        = number
  description = "number of elasticsearch units"
  default     = 1
}

variable "elasticsearch_private_ip" {
  type        = list(string)
  description = "elasticsearch private ip"
}

variable "apm_counts" {
  type        = number
  description = "number of apm units"
  default     = 1
}

variable "apm_private_ip" {
  type        = list(string)
  description = "apm private ip"
}
