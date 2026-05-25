variable "vpc_name" { type = string }
variable "cidr_block" { type = string; default = "10.0.0.0/16" }
variable "availability_zones" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "enable_nat_gateway" { type = bool; default = true }
variable "tags" { type = map(string); default = {} }