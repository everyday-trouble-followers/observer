resource "aws_route53_zone" "private" {
  name          = var.domain_name
  force_destroy = true

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name = "${var.basename}-${terraform.workspace}-zone"
  }
}

resource "aws_route53_record" "kibana" {
  zone_id  = aws_route53_zone.private.zone_id
  for_each = { for index, name in range(1, var.kibana_counts + 1) : index => name }
  name     = "${var.basename}-${terraform.workspace}-kibana-${each.value}.${var.domain_name}"
  type     = "A"
  ttl      = "30"
  records = [
    element(var.kibana_private_ip, each.key)
  ]
}

resource "aws_route53_record" "elasticsearch" {
  zone_id  = aws_route53_zone.private.zone_id
  for_each = { for index, name in range(1, var.elasticsearch_counts + 1) : index => name }
  name     = "${var.basename}-${terraform.workspace}-elasticsearch-${each.value}.${var.domain_name}"
  type     = "A"
  ttl      = "30"
  records = [
    element(var.elasticsearch_private_ip, each.key)
  ]
}

resource "aws_route53_record" "apm" {
  zone_id  = aws_route53_zone.private.zone_id
  for_each = { for index, name in range(1, var.apm_counts + 1) : index => name }
  name     = "${var.basename}-${terraform.workspace}-apm-${each.value}.${var.domain_name}"
  type     = "A"
  ttl      = "30"
  records = [
    element(var.apm_private_ip, each.key)
  ]
}
