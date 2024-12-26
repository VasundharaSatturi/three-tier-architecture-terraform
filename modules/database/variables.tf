variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of DB subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the Aurora DB"
  type        = list(string)
}

variable "master_username" {
  description = "Master username for the Aurora DB"
  type        = string
}

variable "master_password" {
  description = "Master password for the Aurora DB"
  type        = string
}

variable "database_name" {
  description = "Name of the default database"
  type        = string
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "02:00-03:00"
}

variable "instance_count" {
  description = "Number of instances in the Aurora DB cluster"
  type        = number
  default     = 1
}

variable "instance_class" {
  description = "Instance class for the Aurora DB instances"
  type        = string
  default     = "db.r6g.large"
}
