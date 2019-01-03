terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
  version = "~> 1.53"}

resource "aws_instance" "example" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
  tags {
    Name = "created by Terraform"
  }
  key_name = "codecommit_rsa"
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "codecommit_rsa"
  public_key = "${file("/home/nicolas/.ssh/codecommit_rsa.pub")}"
}