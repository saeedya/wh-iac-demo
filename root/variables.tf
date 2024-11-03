variable "project_name" {}
variable "region" {}
variable "vpc_cidr" {}
variable "public_subnet_1a_cidr" {}
variable "public_subnet_2b_cidr" {}
variable "private_subnet_3a_cidr" {}
variable "private_subnet_4b_cidr" {}
variable "private_subnet_5a_cidr" {}
variable "private_subnet_6b_cidr" {}
variable "aws_access_key" {
  type        = string
  sensitive   = true
  description = "AWS access key ID"
}
variable "aws_secret_key" {
  type        = string
  sensitive   = true
  description = "AWS secret access key"
}
variable "db_username" {}
variable "db_password" {}
variable "certificate_domain_name" {}
variable "additional_domain_name" {}
variable "acm_certificate_arn" {}