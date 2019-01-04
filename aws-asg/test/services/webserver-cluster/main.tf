terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "git::ssh://nicolasduminil@github.com/nicolasduminil/aws-web-server-cluster-with-terraform-module.git"
  cluster_name = "webserver-cluster-test"
  db_remote_state_bucket = "${var.s3_bucket_name_for_db_state}"
  db_remote_state_key = "${var.s3_path_for_db_state}"
  instance_type = "t2.micro"
  image_id = "ami-40d28157"
  min_size = 2
  max_size = 2
}

