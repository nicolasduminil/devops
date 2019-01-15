terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
  version = "~> 1.53"
}

resource "aws_instance" "simplex_software" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
  security_groups = [
    "${aws_security_group.simplex_software_default.name}",
    "${aws_security_group.simplex_software_nat.name}"]
  key_name = "simplex-software"
  tags {
    Name = "Simplex Software"
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "simplex-software"
  public_key = "${file("/home/nicolas/.ssh/id_rsa.pub")}"
}


resource "aws_security_group" "simplex_software_default" {
  name = "simplex-software-default"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
    self = true
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
    self = true
  }
  tags {
    Name = "simplex-software-default"
  }
}

resource "aws_security_group" "simplex_software_nat" {
  name = "simplex-software-nat"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = 1194
    to_port = 1194
    protocol = "udp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "simplex-software-nat"
  }
}

resource "aws_ebs_volume" "simplex_software_ebs_20" {
  availability_zone = "us-east-1a"
  size = 20
  type = "gp2"
  tags = {
    Name = "ebs-20"
  }
}

resource "aws_volume_attachment" "simplex_software_att" {
  device_name = "/dev/sdf"
  volume_id   = "${aws_ebs_volume.simplex_software_ebs_20.id}"
  instance_id = "${aws_instance.simplex_software.id}"
}

