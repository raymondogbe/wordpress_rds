resource "aws_s3_bucket" "gabucket" {
  bucket        = "github-action-bucket1"
  force_destroy = true

  tags = {
    Name        = "my-bucket"
    Environment = "Dev"
  }
}
/* resource "aws_s3_bucket_acl" "my-acl" {
  bucket = aws_s3_bucket.gabucket.id
  acl    = "public-read"
} */
