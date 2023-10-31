# initialize things
terraform {
  backend "s3" {
    bucket         = "astute-terraform-remote-state"
    key            = "reporting/Dev/terraform/aws/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "TerraformState"
  }
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::786014450157:role/extAdmin"
    session_name = "DEV"
  }
}

data "aws_ami" "Ubuntu-1804" {
  most_recent = true
  owners      = ["786014450157"]

  filter {
    name   = "name"
    values = ["astute-ubuntu-1804-base-*"]
  }
}

data "aws_ami" "Windows-2019" {
  most_recent = true
  owners      = ["786014450157"]

  filter {
    name   = "name"
    values = ["astute-windows-2019-base-*"]
  }
}

data "aws_acm_certificate" "astutesolutions" {
  domain   = "astutesolutions.org"
  statuses = ["ISSUED"]
}