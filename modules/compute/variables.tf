variable "project_name" {
  description = "The project name"
  type        = string
}

variable "tier" {
    description = "Tier of the project"
    type = string
}

variable "custom_ami_id" {
  description = "The custom AMI ID to use for instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "app_tier_sg_id" {
  description = "App tier security group ID"
  type        = string
}

variable "ec2_instance_profile_arn" {
  description = "EC2 instance profile arn"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ASG"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of instances in ASG"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of instances in ASG"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "asg_instance_id" {
  description = "The instance ID of the auto scaling group instances"
  type        = string
}

variable "ingress_port" {
    description = "The application port"
    type        = string
}


variable "ingress_protocol" {
    description = "The application protocol"
    type        = string
}


variable "internal" {
    description = "whether load balancer is internal or internet facing"
    type = bool
}

variable "lb_sg_id" {
    description = "Load balancer sg id"
    type        = string
}

variable "user_data" {
  description = "The user data script for the launch template"
  type = string
}