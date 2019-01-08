output "elb_dns_name" {
  value = "${aws_elb.simplex_software.dns_name}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.simplex_software.name}"
}

output "elb_security_group_id" {
  value = "${aws_security_group.simplex_software_elb.id}"
}
