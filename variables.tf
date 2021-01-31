###################################################################
# Please set access_key_id, secret_access_key and default region  #
# as environment variables prefixed with "TF_VARS_".              #
# For example, TF_VAR_aws_access_key_id = AKIA********.           #
###################################################################

# environment variables
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_default_region" {}

# common
variable "basename" {
  type        = string
  description = "this project basename."
  default     = "project"
}

# network
variable "vpc_cidr_block" {}
variable "sn_names" {}
