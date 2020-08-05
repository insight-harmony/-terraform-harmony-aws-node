variable "create" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}

variable "create_ansible" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}

########
# Label
########
variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the resources"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to associate with the instance."
  type        = map(string)
  default     = {}
}

#########
# Network
#########
variable "subnet_id" {
  description = "The id of the subnet. Must be supplied if given vpc_id"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The vpc id to associate with.  Must be supplied if given subnet_id"
  type        = string
  default     = ""
}

#################
# Security Groups
#################
variable "create_security_group" {
  description = "Bool to create security group"
  type        = bool
  default     = true
}

variable "additional_security_groups" {
  description = "List of additional security groups"
  type        = list(string)
  default     = []
}

variable "ssh_ips" {
  description = "List of IPs to restrict ssh traffic to"
  type        = list(string)
  default     = null
}

#####
# ec2
#####
variable "node_name" {
  description = "Name of the node"
  type        = string
  default     = ""
}

variable "monitoring_enabled" {
  description = "Enable cloudwatch monitoring on node"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root volume size"
  type        = string
  default     = "90"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.small"
}

variable "public_key" {
  description = "The public ssh key. key_name takes precidence"
  type        = string
  default     = ""
}

variable "public_key_path" {
  description = "The public ssh key path. key_name takes precidence"
  type        = string
  default     = ""
}

variable "private_key_path" {
  description = "Path to private key"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The name of the preexisting key to be used instead of the local public_key_path"
  type        = string
  default     = ""
}
