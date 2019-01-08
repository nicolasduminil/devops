terraform {
  required_version = ">= 0.11, < 0.12"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "simplex_software" {
  bucket = "${var.bucket_name}"
  versioning {
    enabled = true
  }
}
