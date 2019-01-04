terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "simplex_software" {
  name = "simplex_software_mysql_dev_instance"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  username            = "root"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}
