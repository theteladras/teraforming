provider "aws" {
  profile = "default"
  region = "us-west-2"
  shared_credentials_file = "./credentials"
}

resource "aws_s3_bucket" "teraforming_bucket" {
  bucket = "teraforming-bucket-20210929"
  acl = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "sec-teraforming-prod" {
  name = "sec-teraforming-prod"
  description = "allow inbound http and https and all for outbound"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "teraforming": "true"
  }
}

resource "aws_instance" "instance-teraforming-prod" {
  ami = "ami-0ed34781dc2ec3964"
  instance_type = "t2.nano"
  vpc_security_group_ids = [
    aws_security_group.sec-teraforming-prod.id
  ]

  tags = {
    "teraforming": "true"
  }
}
