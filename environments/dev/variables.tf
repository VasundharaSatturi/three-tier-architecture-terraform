variable "project_name" {
    description = "Name of the project"
    default     = "dev-3-tier"
}

variable "vpc_cidr" {
    description = "Name of the project"
    default     = "10.0.0.0/16"
}

variable "availability_zones" {
    description = "Name of the project"
    default     = ["ap-south-1a", "ap-south-1b"]
}

variable "db_master_username" {
  description = "Master username for the DB"
  type        = string
  default     = "admin"
}

variable "db_master_password" {
  description = "Master password for the DB"
  type        = string
  default     = "MyStrongPassw0rd!"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "webappdb"
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "02:00-03:00"
}

variable "db_instance_count" {
  description = "Number of Aurora DB instances"
  type        = number
  default     = 1
}

variable "db_instance_class" {
  description = "Instance class for Aurora DB"
  type        = string
  default     = "db.t3.medium"
}


variable "custom_ami_id" {
  description = "AMI of the app tier"
  type        = string
  default     = "ami-01bff3d0245d54b37"
}

variable "custom_ami_id_web" {
  description = "AMI of the app tier"
  type        = string
  default     = "ami-0564f16a03441ef53"
}
