terraform {
  required_version = ">= 0.11, < 0.12"
}

resource "aws_launch_configuration" "simplex_software" {
  name = "simplex-software-aws-launch-config"
  image_id = "${var.ami_image_id}"
  instance_type = "${var.ec2_instance_type}"
  security_groups = ["${aws_security_group.simplex_software.name}"]
  user_data = "${data.template_file.httpd_data.rendered}"
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "httpd_data" {
  template = "${file("${path.module}/httpd.sh")}"
  vars {
    httpd_server_port = "${var.web_server_port}"
    db_host_name = "${data.terraform_remote_state.db.address}"
    db_port_number = "${data.terraform_remote_state.db.port}"
    //db_host_name = "terraform-20190103174246751500000001.ckhzgawvvdj7.us-east-1.rds.amazonaws.com"
    //db_port_number = "3306"
  }
}

resource "aws_autoscaling_group" "simplex_software" {
  name = "simplex-software-aws-autoscaling-group"
  launch_configuration = "${aws_launch_configuration.simplex_software.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  load_balancers = ["${aws_elb.simplex_software.name}"]
  health_check_type = "ELB"
  min_size = "${var.ec2_instance_min_size}"
  max_size = "${var.ec2_instance_max_size}"
  tag {
    key = "Name"
    value = "${var.web_server_cluster_name}"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "simplex_software" {
  name = "${var.web_server_cluster_name}-security-group"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "simplex_software_inbound" {
  type = "ingress"
  security_group_id = "${aws_security_group.simplex_software.id}"
  from_port = "${var.web_server_port}"
  to_port = "${var.web_server_port}"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

data "aws_availability_zones" "all" {}

resource "aws_elb" "simplex_software" {
  name = "${var.web_server_cluster_name}-elb"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups = ["${aws_security_group.simplex_software_elb.id}"]
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.web_server_port}"
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.web_server_port}/"
  }
}

resource "aws_security_group" "simplex_software_elb" {
  name = "${var.web_server_cluster_name}-security-group-elb"
}

resource "aws_security_group_rule" "simplex_software_elb_inbound" {
  type = "ingress"
  security_group_id = "${aws_security_group.simplex_software_elb.id}"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "simplex_software_outbound" {
  type = "egress"
  security_group_id = "${aws_security_group.simplex_software_elb.id}"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config {
    bucket = "${var.s3_bucket_name_for_db_state}"
    key = "${var.s3_path_for_db_state}"
    region = "us-east-1"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 2
  desired_capacity = 2
  recurrence = "0 9 * * *"
  autoscaling_group_name = "${aws_autoscaling_group.simplex_software.name}"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size = 1
  max_size = 2
  desired_capacity = 1
  recurrence = "0 17 * * *"
  autoscaling_group_name = "${aws_autoscaling_group.simplex_software.name}"
}
