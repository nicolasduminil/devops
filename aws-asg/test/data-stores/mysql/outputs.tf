output "mysql_db_host_name" {
  value = "${aws_db_instance.example.address}"
}

output "mysql_db_port_number" {
  value = "${aws_db_instance.example.port}"
}