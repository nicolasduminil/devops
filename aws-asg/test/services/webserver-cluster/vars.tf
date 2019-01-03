variable "s3_bucket_name_for_db_state" {
  description = "The name of the S3 bucket used for the database's remote state storage"
}

variable "s3_path_for_db_state" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
}