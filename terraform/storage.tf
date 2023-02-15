resource "aws_s3_bucket" "serverless-strapi-bucket" {
  bucket = "serverless-strapi-bucket"
  tags = {
    Name = "serverless-strapi-bucket"
  }
}

resource "aws_iam_user" "serverless-strapi-bucket-user" {
  name = "serverless-strapi-bucket-user"
  tags = {
    Name = "serverless-strapi-bucket-user"
  }
}

resource "aws_iam_group" "serverless-strapi-bucket-user-group" {
  name = "serverless-strapi-bucket-user-group"
}

resource "aws_iam_user_group_membership" "serverless-strapi-user-group-membership" {
  user = aws_iam_user.serverless-strapi-bucket-user.name
  groups = [
    aws_iam_group.serverless-strapi-bucket-user-group.name,
  ]
}

data "aws_iam_policy_document" "bucket-user" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      aws_s3_bucket.serverless-strapi-bucket.arn,
      "${aws_s3_bucket.serverless-strapi-bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "serverless-strapi-bucket-user-policy" {
  name        = "serverless-strapi-bucket-user-policy"
  description = "Policy for bucket user"
  policy      = data.aws_iam_policy_document.bucket-user.json
}

resource "aws_iam_group_policy_attachment" "serverless-strapi-bucket-user-attach" {
  group      = aws_iam_group.serverless-strapi-bucket-user-group.name
  policy_arn = aws_iam_policy.serverless-strapi-bucket-user-policy.arn
}

resource "aws_s3_bucket_acl" "serverless-strapi-bucket-acl" {
  bucket = aws_s3_bucket.serverless-strapi-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "serverless-strapi-bucket-public-access" {
  bucket                  = aws_s3_bucket.serverless-strapi-bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "serverless-strapi-bucket-cors" {
  bucket = aws_s3_bucket.serverless-strapi-bucket.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["localhost"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}
