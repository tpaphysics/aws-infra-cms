resource "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket_name

  tags = {
    Name = var.asw_s3_tag_name
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI para Bucket de Imagens"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:GetObject"
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
      }
    ]
  })
}