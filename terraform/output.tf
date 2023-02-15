output "serverless-strapi-security-group-id" {
  value = aws_security_group.serverless-strapi-security-group.id
}

output "serverless-strapi-subnet-group-1-id" {
  value = aws_subnet.serverless-strapi-subnet-1.id
}

output "serverless-strapi-subnet-group-2-id" {
  value = aws_subnet.serverless-strapi-subnet-2.id
}

output "serverless-strapi-database-address" {
  value = aws_db_instance.serverless-strapi-database.address
}

output "serverless-strapi-database-port" {
  value = aws_db_instance.serverless-strapi-database.port
}

output "serverless-strapi-bucket-user" {
  value = aws_iam_user.serverless-strapi-bucket-user.name
}

output "serverless-strapi-bucket-name" {
  value = aws_s3_bucket.serverless-strapi-bucket.tags["Name"]
}

output "serverless-strapi-bucket-region" {
  value = aws_s3_bucket.serverless-strapi-bucket.region
}
