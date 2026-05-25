output "cluster_endpoint" {
  description = "Writer endpoint"
  value       = aws_rds_cluster.main.endpoint
}

output "cluster_id" {
  description = "Cluster identifier"
  value       = aws_rds_cluster.main.id
}