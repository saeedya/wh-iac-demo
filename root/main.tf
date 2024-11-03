module "vpc" {
  source                 = "../modules/vpc"
  region                 = var.region
  vpc_cidr               = var.vpc_cidr
  project_name           = var.project_name
  public_subnet_1a_cidr  = var.public_subnet_1a_cidr
  public_subnet_2b_cidr  = var.public_subnet_2b_cidr
  private_subnet_3a_cidr = var.private_subnet_3a_cidr
  private_subnet_4b_cidr = var.private_subnet_4b_cidr
  private_subnet_5a_cidr = var.private_subnet_5a_cidr
  private_subnet_6b_cidr = var.private_subnet_6b_cidr
}

module "nat" {
  source = "../modules/nat"
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  igw_id        = module.vpc.igw_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  vpc_id        = module.vpc.vpc_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
}

module "security-group" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
}

# creating Key for instances
module "key" {
  source = "../modules/ssh_key"
}

# Creating Application Load balancer
module "alb" {
  source        = "../modules/alb"
  project_name  = module.vpc.project_name
  alb_sg_id     = module.security-group.alb_sg_id
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  vpc_id        = module.vpc.vpc_id
}

#Ctreating auto-scaling group for instances
module "asg" {
  source        = "../modules/asg"
  project_name  = module.vpc.project_name
  key_name      = module.key.key_name
  client_sg_id  = module.security-group.client_sg_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  tg_arn        = module.alb.tg_arn
}

# creating RDS instance
module "rds" {
  source        = "../modules/rds"
  db_sg_id      = module.security-group.db_sg_id
  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
  db_username   = var.db_username
  db_password   = var.db_password
}

# create cloudfront distribution 
module "cloudfront" {
  source                  = "../modules/cloudfront"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name         = module.alb.alb_dns_name
  additional_domain_name  = var.additional_domain_name
  project_name            = module.vpc.project_name
  acm_certificate_arn     = var.acm_certificate_arn
}

# Add record in route 53 hosted zone
module "route53" {
  source                    = "../modules/route53"
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id

}