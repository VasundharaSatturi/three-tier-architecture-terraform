resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.project_name}-db-subnet-group"
  subnet_ids  = var.db_subnet_ids
  description = "Subnet group for Aurora DB cluster"
}

data "aws_rds_engine_version" "aurora_mysql" {
  engine         = "aurora-mysql"
  preferred_versions = ["8.0.mysql_aurora.3.04.2"]
}


resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.project_name}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = data.aws_rds_engine_version.aurora_mysql.version
  master_username         = var.master_username
  master_password         = var.master_password
  database_name           = var.database_name
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window

  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name

  storage_encrypted       = true
  apply_immediately       = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = var.instance_count
  identifier         = "${var.project_name}-aurora-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  engine             = "aurora-mysql"
  engine_version     = data.aws_rds_engine_version.aurora_mysql.version
  apply_immediately  = true
}