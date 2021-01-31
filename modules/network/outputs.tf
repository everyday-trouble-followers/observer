output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = [
    for subnet in aws_subnet.public :
    subnet.id
  ]
}
