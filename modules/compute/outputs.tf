output "launch_template_id" {
  description = "ID of the created Launch Template"
  value       = aws_launch_template.lt.id
}

output "asg_name" {
  description = "Name of the created Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "asg_id" {
  description = "Name of the created Auto Scaling Group"
  value       = aws_autoscaling_group.asg.id
}

output "dns_name" {
  description = "Name of the created Auto Scaling Group"
  value       = aws_lb.lb.dns_name
}