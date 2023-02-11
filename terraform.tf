resource "aws_vpc" "terraform-vpc" {
  cidr_block       = var.vpc-cidr-blk
  instance_tenancy = lookup(var.aws-grp, "tenancy")

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "terraform-subnet" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = var.subnet-cidr-blk

  tags = {
    Name = var.subnet-name
  }
}

resource "aws_security_group" "terraform-secgrp" {
  description = "My first terraform sec. group"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description      = "Open to all incoming traffic"
    from_port        = 0
    to_port          = 0
    protocol         = var.protocol
    cidr_blocks      = [var.ipv4-cidr-blk]
    ipv6_cidr_blocks = [var.ipv6-cidr-blk]
  }

  egress {
    description      = "Open to all outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = var.protocol
    cidr_blocks      = [var.ipv4-cidr-blk]
    ipv6_cidr_blocks = [var.ipv6-cidr-blk]
  }

  tags = {
    Name = var.secgrp-name
  }
}

resource "aws_instance" "terraform-ec2" {
  ami = var.ami
  instance_type = var.ami_type
  tenancy = lookup(var.aws-grp, "tenancy")
  subnet_id = aws_subnet.terraform-subnet.id
  vpc_security_group_ids = [aws_security_group.terraform-secgrp.id]
  key_name = lookup(var.aws-grp, "key_name")
  associate_public_ip_address = true
  tags = {
    Name = var.inst-name
  }
}

output "instance_public_ip" {
  value = aws_instance.terraform-ec2.public_ip
}
