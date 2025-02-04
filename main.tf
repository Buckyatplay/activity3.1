locals {
 name_prefix = "choonyee"
}

# S3 bucket
resource "aws_s3_bucket" "static_bucket" {
 bucket = "choonyees3.sctp-sandbox.com"
 force_destroy = true
}

## EC2 Instance
resource "aws_instance" "dynamodb_reader" {
  ami                    = "ami-04c913012f8977029"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.dynamodb_reader.id]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.profile_dynamodb.id

  tags = {
    Name = "${local.name_prefix}-dynamodb-reader"
  }
}