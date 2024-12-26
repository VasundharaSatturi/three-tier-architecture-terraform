# Output the ARN of the IAM role
output "iam_role_arn" {
  description = "ARN of the IAM role created for EC2"
  value       = aws_iam_role.ec2_role.name
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.arn
}