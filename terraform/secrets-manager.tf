resource "aws_secretsmanager_secret" "serverless-strapi-database-secrets" {
  name        = "serverless-strapi-database-secrets"
  description = "access to serverless-strapi database secrets"
}

resource "aws_secretsmanager_secret_version" "serverless-strapi-database-secrets" {
  secret_id = aws_secretsmanager_secret.serverless-strapi-database-secrets.id
  secret_string = jsonencode({
    DATABASE_HOST     = "${aws_db_instance.serverless-strapi-database.address}"
    DATABASE_PORT     = "${var.serverless-strapi-database-secrets.DATABASE_PORT}"
    DATABASE_NAME     = "${var.serverless-strapi-database-secrets.DATABASE_NAME}"
    DATABASE_USERNAME = "${var.serverless-strapi-database-secrets.DATABASE_USERNAME}"
    DATABASE_PASSWORD = "${var.serverless-strapi-database-secrets.DATABASE_PASSWORD}"
    }
  )
}
