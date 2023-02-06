resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "terraform-subnet" {
  vpc_id = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-subnet"
  }
}

resource "aws_security_group" "terraform-secgrp" {
  description = "My first terraform sec. group"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description      = "Open to all incoming traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Open to all outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform-secgrp"
  }
}

resource "aws_instance" "terraform-ec2" {
  ami = "ami-042bbe4a84b81d198"
  instance_type = "t2.micro"
  tenancy = "default"
  subnet_id = aws_subnet.terraform-subnet.id
  vpc_security_group_ids = [aws_security_group.terraform-secgrp.id]
  key_name = "devops"
  associate_public_ip_address = true
  tags = {
    Name = "terraform-ec2"
  }
}

output "instance_public_ip" {
  value = aws_instance.terraform-ec2.public_ip
}
