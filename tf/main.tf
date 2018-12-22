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
  //public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfMCqXraSPxvhL2LIGluGC7Y8UsV1PuMcH1L3u7zdHnMQl0CzAt+1yjqdcbu/OVDBMtoPfimTp5BxawuodDdEEewNSOonL517oSQqwdaunkoy6bioITMvj6iiG4ab3thy0BaT0MWb7Thbf8KDHPIxLm0fdgJHSOhXRb6TEToNCi+zm9BVYcKiYK6HBfnh4wp9CI2pyhZ1OEhly/8K+SjQzg4j8TR/5EH7JEiCl64Y5gXwNxLDyjHHiGMqk2sv6EfxRncroAYVhonG/N63Fkd1BTOIWLNovgId/ehw/+ejh2LHi5Y7+whgPzVqaFfzmhXW/RSRMaAmxeAoLZWDUpeGx kayanazimov@kayanazimov.local"
  public_key = "${file("/home/nicolas/.ssh/codecommit_rsa.pub")}"
}