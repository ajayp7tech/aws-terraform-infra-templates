variable "cluster_id" { type = string }
variable "node_type" { type = string; default = "cache.t3.medium" }
variable "num_cache_nodes" { type = number; default = 2 }
variable "automatic_failover" { type = bool; default = true }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "at_rest_encryption_enabled" { type = bool; default = true }
variable "transit_encryption_enabled" { type = bool; default = true }
variable "tags" { type = map(string); default = {} }