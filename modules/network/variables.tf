# common
variable "basename" {}

# network
variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block size."
  default     = "10.0.0.0/16"
}

variable "sn_names" {
  type        = list(string)
  description = "subnet names."
  default = [
    "A",
    "B"
  ]
}
