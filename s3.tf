resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}-${var.frontend}-${var.env_type}"
  acl    = "private"

  tags = {
    Name = "frontend bucket"
  }
}

output "bucket" {
  value = aws_s3_bucket.bucket.bucket
}
