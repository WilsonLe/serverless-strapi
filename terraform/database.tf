resource "aws_db_subnet_group" "serverless-strapi-subnet-group" {
  name       = "serverless-strapi-subnet-group"
  subnet_ids = [aws_subnet.serverless-strapi-subnet-1.id, aws_subnet.serverless-strapi-subnet-2.id]

  tags = {
    Name = "serverless-strapi-subnet-group"
  }
}

resource "aws_db_instance" "serverless-strapi-database" {
  allocated_storage      = 10
  identifier             = "serverless-strapi-database"
  db_name                = var.serverless-strapi-database-secrets.DATABASE_NAME
  engine                 = "postgres"
  engine_version         = "13.7"
  instance_class         = "db.t3.micro"
  username               = var.serverless-strapi-database-secrets.DATABASE_USERNAME
  password               = var.serverless-strapi-database-secrets.DATABASE_PASSWORD
  parameter_group_name   = "default.postgres13"
  publicly_accessible    = true
  skip_final_snapshot    = true
  apply_immediately      = true
  vpc_security_group_ids = [aws_security_group.serverless-strapi-security-group.id]
  db_subnet_group_name   = aws_db_subnet_group.serverless-strapi-subnet-group.name
}
