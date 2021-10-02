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

resource "aws_security_group" "sec_teraforming_prod" {
  name = "sec_teraforming_prod"
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

resource "aws_instance" "instance_teraforming_prod" {
  count = 2

  ami = "ami-0ed34781dc2ec3964"
  instance_type = "t2.nano"
  vpc_security_group_ids = [
    aws_security_group.sec_teraforming_prod.id
  ]

  tags = {
    "teraforming": "true"
  }
}

resource "aws_eip_association" "eip_associate_teraforming_prod" {
  instance_id = aws_instance.instance_teraforming_prod.0.id
  allocation_id = aws_eip.eip_teraforming_prod.id
}

resource "aws_eip" "eip_teraforming_prod" {
  tags = {
    "teraforming": "true"
  }
}
