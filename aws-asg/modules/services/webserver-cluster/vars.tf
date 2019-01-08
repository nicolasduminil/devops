variable "web_server_port" {
  description = "The TCP port the server will use for HTTP requests"
  default     = 8080
}

variable "web_server_cluster_name" {
  description = "The name to use for all the cluster resources"
}

variable "s3_bucket_name_for_db_state" {
  description = "The name of the S3 bucket for the database's remote state"
}

variable "s3_path_for_db_state" {
  description = "The path for the database's remote state in S3"
}

variable "ec2_instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}

variable "ami_image_id" {
  description = "The ID of the AMI"
}

variable "ec2_instance_min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
}

variable "ec2_instance_max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
}

variable "environment_name" {
  description = "The name of the environment (e.g. dev or test)"
}
