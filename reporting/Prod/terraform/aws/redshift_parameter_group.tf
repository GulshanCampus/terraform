resource "aws_redshift_parameter_group" "redshift-SSL-pg" {
  name   = "reporting-ssl-pg"
  family = "redshift-1.0"

  parameter {
    name  = "require_ssl"
    value = "true"
  }
}
