output "db_cluster_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "db_cluster_reader_endpoint" {
  value = aws_rds_cluster.aurora.reader_endpoint
}