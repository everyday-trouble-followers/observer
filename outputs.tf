output "ssh-kibana" {
  value = [
    for dns in module.ec2.kibana_public_dns :
    "ssh -i ${module.key_pair.private_key_file} ec2-user@${dns}"
  ]
}

output "ssh-elasticsearch" {
  value = [
    for dns in module.ec2.elasticsearch_public_dns :
    "ssh -i ${module.key_pair.private_key_file} ec2-user@${dns}"
  ]
}

output "ssh-apm" {
  value = [
    for dns in module.ec2.apm_public_dns :
    "ssh -i ${module.key_pair.private_key_file} ec2-user@${dns}"
  ]
}
