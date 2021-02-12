### common
variable "basename" {}

### key_pair
variable "key_file_path" {
  type        = string
  description = "key pair file path."
  default     = "~/.ssh/"
}
