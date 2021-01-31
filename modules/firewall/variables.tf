### common
variable "basename" {}

### firewall
variable "vpc_id" {
  type        = string
  description = "vpc id from vpc resource in Networking module"
}

variable "ingress_management_ports" {
  type        = map(number)
  description = "Open these ports of servers for management from somewhere."
  default = {
    "ssh" : 22,
    "http" : 80,
    "https" : 443,
  }
}

variable "ingress_management_cidr_blocks" {
  type        = list(string)
  description = "Open these cidr blocks of servers for management from somewhere."
}

variable "ingress_function_ports" {
  type        = map(number)
  description = "Open these ports of servers for function from somewhere."
  default = {
    "elasticsearch" : 9200,
    "apm" : 8200,
  }
}

variable "ingress_function_cidr_blocks" {
  type        = list(string)
  description = "Open these cidr blocks of servers for function from somewhere."
  default     = ["10.0.0.0/16"]
}

