# initialize things
terraform {
  backend "s3" {
    bucket         = "astute-terraform-remote-state"
    key            = "epowercenter/Prod/terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "TerraformState"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "Windows-2019" {
  most_recent = true
  owners      = ["156063083762"]

  filter {
    name   = "name"
    values = ["astute-windows-2019-base-*"]
  }
}

data "aws_ami" "Windows-2012" {
  most_recent = true
  owners      = ["156063083762"]

  filter {
    name   = "name"
    values = ["astute-windows-2012-r2-base-*"]
  }
}

data "aws_ami" "Ubuntu-1804" {
  most_recent = true
  owners      = ["156063083762"]

  filter {
    name   = "name"
    values = ["astute-ubuntu-1804-base-*"]
  }
}

data "aws_vpc" "astute-saas-vpc" {
  id = "vpc-e0a6ad8a"
}

data "aws_subnet" "saas-app-subnet-1a" {
  id = "subnet-09ba9051"
}

data "aws_subnet" "saas-app-subnet-1c" {
  id = "subnet-d72c07fd"
}

data "aws_subnet" "saas-app-subnet-1d" {
  id = "subnet-a1c112e8"
}

data "aws_subnet" "saas-dmz-subnet-1a" {
  id = "subnet-f8a6ad92"
}

data "aws_subnet" "saas-dmz-subnet-1c" {
  id = "subnet-0a443822"
}

data "aws_subnet" "saas-dmz-subnet-1d" {
  id = "subnet-f8cbeb8f"
}
