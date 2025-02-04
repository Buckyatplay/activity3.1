locals {
 name_prefix = "choonyee"
}

# S3 bucket
resource "aws_s3_bucket" "static_bucket" {
 bucket = "choonyees3.sctp-sandbox.com"
 force_destroy = true
}

