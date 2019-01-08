# Web server cluster module

This folder contains a [Terraform](https://www.terraform.io/) template that defines a module for deploying an 
AWS infrastructure with the following architecture elements: 
* a cluster of web servers using [EC2](https://aws.amazon.com/ec2/)
* an auto-scalling group using [Auto Scaling](https://aws.amazon.com/autoscaling/))
* a load balancer (using [ELB](https://aws.amazon.com/elasticloadbalancing/))  

The load balancer listens on port 80 and returns the text "Hello, World" for the `/` URL.

## Quick start

This Terraform module is not meant to be deployed directly. Instead, they are referenced from other templates. See
[dev/services/webserver-cluster](../../../dev/services-webserver-cluster) and
[test/services/webserver-cluster](../../../test/services-webserver-cluster) for examples.