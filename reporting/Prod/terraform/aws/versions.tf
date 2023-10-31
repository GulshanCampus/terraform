terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    template = {
      source = "hashicorp/template"
    }

    #  required_version = ">= 0.13"
    redshift = {
      source  = "brainly/redshift"
      version = "1.0.4"
    }
  }
}
