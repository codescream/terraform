#variable "key_name" {
#  description = "This is the key-pair for the instance"
#  default = "devops"
#}

variable "aws-grp" {
  type = map(string)
  default = {
  tenancy = "default"
  key_name = "devops"
  }
}

variable "ami" {
  description = "AMI for instance"
  default = "ami-042bbe4a84b81d198"
}

variable "ami_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "vpc-cidr-blk" {
  description = "vpc cidr block"
  default = "10.0.0.0/16"
}

variable "subnet-cidr-blk" {
  description = "subnet cidr block"
  default = "10.0.1.0/24"
}

variable "vpc-name" {
  description = "vpc tag name"
  default = "terraform-vpc"
}

variable "subnet-name" {
  description = "subnet tag name"
  default = "terraform-subnet"
}

variable "protocol" {
  description = "ingress-egress protocol"
  default = "-1"
}

variable "inst-name" {
  description = "instance name"
  default = "terraform-ec2"
}

#variable "tenancy" {
#  description = "tenancy"
#  default = "default"
#}

variable "secgrp-name" {
  description = "instance name"
  default = "terraform-secgrp"
}

variable "ipv4-cidr-blk" {
  description = "ipv4 cidr block rule"
  default = "0.0.0.0/0"
}

variable "ipv6-cidr-blk" {
  description = "ipv6 cidr block rule"
  default = "::/0"
}
