
resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = local.name
  description = "Security group for Harmony Nodes"

  vpc_id = var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id

  tags = var.tags
}

locals {
  ssh_cidr = var.ssh_ips == null ? ["0.0.0.0/0"] : [for i in var.ssh_ips : "${i}/32"]
}

resource "aws_security_group_rule" "ssh" {
  count = var.create_security_group ? 1 : 0

  description       = "SSH"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = local.ssh_cidr
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

resource "aws_security_group_rule" "state_sync" {
  count = var.create_security_group ? 1 : 0

  description       = "Harmony Node State Syncing Port"
  from_port         = 6000
  to_port           = 6000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

resource "aws_security_group_rule" "basic" {
  count = var.create_security_group ? 1 : 0

  description       = "Harmony Basic Port"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

resource "aws_security_group_rule" "rpc" {
  count = var.create_security_group ? 1 : 0

  description       = "Harmony RPC Port"
  from_port         = 9500
  to_port           = 9500
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "ingress"
}

resource "aws_security_group_rule" "egress" {
  count = var.create_security_group ? 1 : 0

  description       = "Egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.this.*.id)
  type              = "egress"
}