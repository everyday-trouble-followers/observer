resource "aws_instance" "kibana" {
  for_each               = { for index, name in range(1, var.kibana_counts + 1) : index => name }
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type_kibana
  vpc_security_group_ids = var.security_group_ids_kibana
  key_name               = var.key_name
  subnet_id              = var.subnet_id_kibana
  user_data              = data.template_file.user_data_kibana.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size_kibana
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name = "${var.basename}-${terraform.workspace}-kibana-${each.value}"
  }
}

resource "aws_instance" "elasticsearch" {
  for_each               = { for index, name in range(1, var.elasticsearch_counts + 1) : index => name }
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type_elasticsearch
  vpc_security_group_ids = var.security_group_ids_elasticsearch
  key_name               = var.key_name
  subnet_id              = var.subnet_id_elasticsearch
  user_data              = data.template_file.user_data_elasticsearch.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size_elasticsearch
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name = "${var.basename}-${terraform.workspace}-elasticsearch-${each.value}"
  }
}

resource "aws_instance" "apm" {
  for_each               = { for index, name in range(1, var.apm_counts + 1) : index => name }
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type_apm
  vpc_security_group_ids = var.security_group_ids_apm
  key_name               = var.key_name
  subnet_id              = var.subnet_id_apm
  user_data              = data.template_file.user_data_apm.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size_apm
  }

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name = "${var.basename}-${terraform.workspace}-apm-${each.value}"
  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}

data "template_file" "user_data_kibana" {
  template = file("${var.template_file_path}/kibana.yml.tpl")

  vars = {
    elastic_version            = var.elastic_version
    kibana_server_port         = tostring(var.kibana_server_port)
    kibana_server_host         = var.kibana_server_host
    kibana_server_name         = var.kibana_server_name
    kibana_elasticsearch_hosts = "[ ${join(",", [for count in range(1, var.elasticsearch_counts + 1) : format("%q", "${var.basename}-${terraform.workspace}-elasticsearch-${count}.${var.domain_name}")])} ]"
  }
}

data "template_file" "user_data_elasticsearch" {
  template = file("${var.template_file_path}/elasticsearch.yml.tpl")

  vars = {
    elastic_version                            = var.elastic_version
    elasticsearch_jvm_Xms                      = var.elasticsearch_jvm_Xms
    elasticsearch_jvm_Xmx                      = var.elasticsearch_jvm_Xmx
    elasticsearch_cluster_name                 = var.basename
    elasticsearch_node_name                    = var.elasticsearch_node_name
    elasticsearch_network_host                 = "[ ${join(",", [for s in var.elasticsearch_network_host : format("%q", s)])} ]"
    elasticsearch_http_port                    = tostring(var.elasticsearch_http_port)
    elasticsearch_discovery_seed_hosts         = "[ ${join(",", [for count in range(1, var.elasticsearch_counts + 1) : format("%q", "${var.basename}-${terraform.workspace}-elasticsearch-${count}.${var.domain_name}")])} ]"
    elasticsearch_cluster_initial_master_nodes = "[ ${join(",", [for count in range(1, var.elasticsearch_counts + 1) : format("%q", "${var.basename}-${terraform.workspace}-elasticsearch-${count}.${var.domain_name}")])} ]"
  }
}

data "template_file" "user_data_apm" {
  template = file("${var.template_file_path}/apm.yml.tpl")

  vars = {
    elastic_version                = var.elastic_version
    apm_server_host                = var.apm_server_host
    apm_output_elasticsearch_hosts = "[ ${join(",", [for count in range(1, var.elasticsearch_counts + 1) : format("%q", "${var.basename}-${terraform.workspace}-elasticsearch-${count}.${var.domain_name}")])} ]"
  }
}
