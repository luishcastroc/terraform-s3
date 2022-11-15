resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}-${var.frontend}-${var.env_type}"  

  tags = {
    Name = "frontend bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.bucket.bucket
  acl    = "private"
}

output "bucket" {
  value = aws_s3_bucket.bucket.bucket
}
