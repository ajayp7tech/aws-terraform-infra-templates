variable "cluster_identifier" { type = string }
variable "engine_version" { type = string; default = "15.4" }
variable "instance_class" { type = string; default = "db.r6g.large" }
variable "instance_count" { type = number; default = 2 }
variable "database_name" { type = string }
variable "master_username" { type = string; default = "dbadmin" }
variable "master_password" { type = string; sensitive = true }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "backup_retention_period" { type = number; default = 7 }
variable "deletion_protection" { type = bool; default = true }
variable "storage_encrypted" { type = bool; default = true }
variable "tags" { type = map(string); default = {} }