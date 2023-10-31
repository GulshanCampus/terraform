resource "aws_s3_bucket" "rpt-codedeploy-dev" {
  bucket = "rpt-codedeploy-dev"
  acl    = "private"

  tags = {
    Name        = "rpt-codedeploy-dev"
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }
}

resource "aws_s3_bucket" "rpt-database-uploads" {
  bucket = var.rpt_database_uploads
  acl    = "private"

  tags = {
    Name        = var.rpt_database_uploads
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }
}
