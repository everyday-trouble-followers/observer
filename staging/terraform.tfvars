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
ingress_management_cidr_blocks = null
ingress_function_ports = {
  "elasticsearch" : 9200,
  "apm" : 8200,
}
ingress_function_cidr_blocks = [ "10.0.0.0/16" ]