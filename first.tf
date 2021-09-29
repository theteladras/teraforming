provider "aws" {
  profile = "default"
  region = "us-west-2"
}

resource "aws_s3_bucket" "teraforming_bucket" {
  bucket = "teraforming-bucket-20210929"
  acl = "private"
}
