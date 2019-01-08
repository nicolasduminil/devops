terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  //source = "git@github.com:nicolasduminil/aws-web-server-cluster-with-terraform-module.git"
  source = "../../../modules/services/webserver-cluster/"
  web_server_cluster_name = "webserver-cluster-dev"
  s3_bucket_name_for_db_state = "simplex-software-s3-bucket"
  s3_path_for_db_state = "dev/data-stores/mysql/terraform.tfstate"
  ec2_instance_type = "t2.micro"
  ami_image_id = "ami-40d28157"
  ec2_instance_min_size = 2
  ec2_instance_max_size = 2
  environment_name = "dev"
}

