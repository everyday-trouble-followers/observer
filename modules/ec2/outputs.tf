output "kibana_ids" {
  value = [
    for kibana in aws_instance.kibana :
    kibana.id
  ]
}

output "elasticsearch_ids" {
  value = [
    for elasticsearch in aws_instance.elasticsearch :
    elasticsearch.id
  ]
}

output "apm_ids" {
  value = [
    for apm in aws_instance.apm :
    apm.id
  ]
}

output "kibana_public_dns" {
  value = [
    for kibana in aws_instance.kibana :
    kibana.public_dns
  ]
}

output "elasticsearch_public_dns" {
  value = [
    for elasticsearch in aws_instance.elasticsearch :
    elasticsearch.public_dns
  ]
}
output "apm_public_dns" {
  value = [
    for apm in aws_instance.apm :
    apm.public_dns
  ]
}

output "kibana_private_ip" {
  value = [
    for kibana in aws_instance.kibana :
    kibana.private_ip
  ]
}

output "elasticsearch_private_ip" {
  value = [
    for elasticsearch in aws_instance.elasticsearch :
    elasticsearch.private_ip
  ]
}

output "apm_private_ip" {
  value = [
    for apm in aws_instance.apm :
    apm.private_ip
  ]
}
