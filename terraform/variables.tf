variable "region" {
  type = string
}

variable "serverless-strapi-database-secrets" {
  type      = map(string)
  sensitive = true
}
