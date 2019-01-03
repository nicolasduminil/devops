terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "https://github.com/nicolasduminil/aws-web-server-cluster-with-terraform-module.git?ref=dev.v0.0.2"
  cluster_name = "webserver-cluster-test"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key = "${var.db_remote_state_key}"
  instance_type = "t2.micro"
  image_id = "ami-40d28157"
  min_size = 2
  max_size = 2
}

