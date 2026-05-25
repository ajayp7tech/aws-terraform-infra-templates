terraform {
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
  }
}
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.cluster_id}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}
resource "aws_elasticache_replication_group" "main" {
  replication_group_id       = var.cluster_id
  description                = "Redis cluster for ${var.cluster_id}"
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_nodes
  automatic_failover_enabled = var.automatic_failover
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  tags                       = var.tags
}