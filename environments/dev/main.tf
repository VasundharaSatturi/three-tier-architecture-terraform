module "ec2_iam_role" {
  source        = "../../modules/IAM"
  project_name  = var.project_name
}

module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  project_name       = var.project_name
}

module "security_groups" {
  source       = "../../modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "aurora_db" {
  source              = "../../modules/database"
  project_name        = var.project_name
  db_subnet_ids       = module.vpc.private_db_subnets
  security_group_ids  = [module.security_groups.db_tier_sg_id]
  master_username     = var.db_master_username
  master_password     = var.db_master_password
  database_name       = var.db_name
  backup_retention_period = var.db_backup_retention_period
  preferred_backup_window = var.db_backup_window
  instance_count      = var.db_instance_count
  instance_class      = var.db_instance_class
}

#Create App tier compute components
module "ec2_autoscaling" {
  source = "../../modules/compute"

  project_name             = var.project_name
  custom_ami_id            = var.custom_ami_id
  tier                     = "app"
  instance_type            = "t2.micro"
  app_tier_sg_id           = module.security_groups.app_tier_sg_id
  ec2_instance_profile_arn = module.ec2_iam_role.iam_instance_profile
  subnet_ids               = module.vpc.private_subnets
  vpc_id                   = module.vpc.vpc_id
  asg_instance_id          = module.ec2_autoscaling.asg_id
  ingress_port             = "4000"
  ingress_protocol         = "HTTP"
  internal                 = true
  lb_sg_id                 = module.security_groups.internal_alb_sg_id
  user_data                = file("${path.module}/app-tier-user-data.sh")
}

module "ec2_autoscaling_2" {
  source = "../../modules/compute"

  project_name             = var.project_name
  custom_ami_id            = var.custom_ami_id_web
  tier                     = "web"
  instance_type            = "t2.micro"
  app_tier_sg_id           = module.security_groups.web_tier_sg_id
  ec2_instance_profile_arn = module.ec2_iam_role.iam_instance_profile
  subnet_ids               = module.vpc.public_subnets
  vpc_id                   = module.vpc.vpc_id
  asg_instance_id          = module.ec2_autoscaling_2.asg_id
  ingress_port             = "80"
  ingress_protocol         = "HTTP"
  internal                 = false
  lb_sg_id                 = module.security_groups.internet_alb_sg_id
  user_data                = file("${path.module}/web-tier-user-data.sh")
}