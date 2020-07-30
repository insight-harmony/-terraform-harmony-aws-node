output "subnet_id" {
  value = var.subnet_id
}

output "security_group_ids" {
  value = compact(concat([join("", aws_security_group.this.*.id)], var.additional_security_groups))
}

output "instance_id" {
  value = join("", aws_instance.this.*.id)
}

output "public_ip" {
  value = join("", aws_eip.this.*.public_ip)
}

output "private_ip" {
  value = join("", aws_instance.this.*.private_ip)
}

output "user_data" {
  value = join("", aws_instance.this.*.user_data)
}
