resource "random_pet" "this" {}

data "aws_region" "this" {}

locals {
  name = var.name == "" ? "harmony-validator-${random_pet.this.id}" : var.name
}

#########
# Network
#########
data "aws_vpc" "default" {
  default = true
}

locals {
  vpc_security_group_ids = compact(concat([join("", aws_security_group.this.*.id)], var.additional_security_groups))
}

resource "null_resource" "is_array_length_correct" {
  count = var.subnet_id == null && var.vpc_id == "" || var.subnet_id != "" && var.vpc_id != "" ? 0 : 1

  provisioner "local-exec" {
    command = "both vpc_id and subnet_id must be filled in together"
  }
}

####
# IP
####
resource "aws_eip" "this" {
  count = var.create ? 1 : 0

  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

resource "aws_eip_association" "this" {
  count = var.create ? 1 : 0

  allocation_id = aws_eip.this.*.id[count.index]
  instance_id   = aws_instance.this.*.id[0]
}

##########
# Instance
##########
module "user_data" {
  source         = "github.com/insight-harmony/terraform-harmony-user-data.git?ref=master"
  type           = "validator"
  cloud_provider = "aws"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = [
    "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = [
    "hvm"]
  }
  owners = [
  "099720109477"]
}

resource "aws_key_pair" "this" {
  count      = var.key_name == "" && var.create ? 1 : 0
  public_key = var.public_key == "" ? file(var.public_key_path) : var.public_key
}

resource "aws_instance" "this" {
  count = var.create ? 1 : 0

  instance_type = var.instance_type
  user_data     = module.user_data.user_data

  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.subnet_id
  vpc_security_group_ids = local.vpc_security_group_ids

  key_name = concat(aws_key_pair.this.*.key_name, [
  var.key_name])[0]
  monitoring = var.monitoring_enabled

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = merge({
    Name : var.node_name
  }, var.tags)
}

#########
# Ansible
#########
module "ansible" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.12.0"
  create = var.create_ansible && var.create

  ip = join("", aws_eip_association.this.*.public_ip)

  user = "ubuntu"

  private_key_path = var.private_key_path

  playbook_file_path     = "${path.module}/ansible/main.yml"
  requirements_file_path = "${path.module}/ansible/requirements.yml"

  playbook_vars = {

  }
}

