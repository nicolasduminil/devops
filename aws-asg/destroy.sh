cd dev/services/webserver-cluster
terraform destroy
cd ../../data-stores/mysql
terraform destroy
cd ../../../global/s3
terraform destroy
