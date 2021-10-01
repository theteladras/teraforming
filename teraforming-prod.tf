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
