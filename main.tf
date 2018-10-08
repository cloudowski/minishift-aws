provider "aws" {
  region = "eu-west-1"
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_ami" "centos" {
  most_recent = true

  owners = ["679593333241"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7*"]
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "minishift-aws"
  description = "Security group for Minishift on AWS"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress_cidr_blocks = ["${var.access_ip}"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name                        = "minishift-aws"
  key_name                    = "${var.key_name}"
  ami                         = "${data.aws_ami.centos.id}"
  instance_type               = "t3.medium"
  cpu_credits                 = "unlimited"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  associate_public_ip_address = true
}
