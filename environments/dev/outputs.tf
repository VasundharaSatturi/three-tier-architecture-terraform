
output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_db_subnets" {
  value = module.vpc.private_db_subnets
}

output "security_groups" {
  value = {
    internet_alb_sg_id = module.security_groups.internet_alb_sg_id
    web_tier_sg_id     = module.security_groups.web_tier_sg_id
    internal_alb_sg_id = module.security_groups.internal_alb_sg_id
    app_tier_sg_id     = module.security_groups.app_tier_sg_id
    db_tier_sg_id      = module.security_groups.db_tier_sg_id
  }
}

output "internal_lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.ec2_autoscaling.dns_name
}

output "public_lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.ec2_autoscaling_2.dns_name
}


output "rds_endpoint" {
  description = "DNS endpoint of Aurora DB"
  value       = module.aurora_db.db_cluster_endpoint
}