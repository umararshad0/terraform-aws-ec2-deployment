variable "aws_region" {
  description = "AWS region containing the selected subnet and AMI."
  type        = string
  default     = "eu-north-1"
}

variable "ssh_cidr" {
  description = "Trusted IPv4 CIDR allowed to connect over SSH."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_cidr)) && can(regex("/32$", var.ssh_cidr))
    error_message = "Set one trusted IPv4 address as a /32 CIDR; broad SSH ranges are not allowed."
  }
}

variable "ami_id" {
  description = "Ubuntu AMI ID for the selected AWS region and architecture."
  type        = string
  validation {
    condition     = can(regex("^ami-[0-9a-f]+$", var.ami_id))
    error_message = "Provide a valid AMI ID for the selected region."
  }
}

variable "subnet_id" {
  description = "Public subnet ID in the selected AWS region."
  type        = string
  validation {
    condition     = can(regex("^subnet-[0-9a-f]+$", var.subnet_id))
    error_message = "Provide a valid subnet ID for the selected region."
  }
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in the selected region."
  type        = string
  validation {
    condition     = length(trimspace(var.key_name)) > 0
    error_message = "Provide the name of an existing EC2 key pair."
  }
}
