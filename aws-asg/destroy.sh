cd global/s3
terraform destroy
cd ../../dev/data-stores/mysql
terraform destroy
cd ../../services/webserver-cluster
terraform destroy