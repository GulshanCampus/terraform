variable "Environment" {
  type    = string
  default = "dev"
}

variable "Product" {
  type    = string
  default = "reporting"
}

variable "Terraform" {
  type    = string
  default = "reporting/Dev/terraform/aws/"
}

variable "astute_vpn" {
  type    = string
  default = "4.7.156.50/32"
}

variable "dev" {
  type    = string
  default = "172.16.1.36/32"
}

variable "rpt_database_uploads" {
  type    = string
  default = "rpt-database-uploads-dev"
}
