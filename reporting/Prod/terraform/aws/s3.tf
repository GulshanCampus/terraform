resource "aws_s3_bucket" "astute-tableau-lb-logs" {
  bucket = "astute-tableau-lb-logs"

  grant {
    permissions = [
      "READ_ACP",
      "WRITE"
    ]
    type = "Group"
    uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
  grant {
    id = "9f4b5d7258201e30895dab4592a2619591ecd0f8c948330ad9e3e8edcd519c2f"
    permissions = [
      "FULL_CONTROL"
    ]
    type = "CanonicalUser"
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 0
    id                                     = "Delete-Logs-21-days"
    expiration {
      days                         = "21"
      expired_object_delete_marker = false
    }
  }

  versioning {
    enabled    = false
    mfa_delete = false
  }
  tags = {
    Name        = "astute-tableau-lb-logs"
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }
}

resource "aws_s3_bucket_policy" "lb-policy" {
  bucket = aws_s3_bucket.astute-tableau-lb-logs.id

  policy = <<POLICY
{
  "Id": "AllowLBLogs",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "s3putlogs",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::astute-tableau-lb-logs/AWSLogs/*",
      "Principal": {
        "AWS": [
          "127311923021"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "astute-tableau" {
  bucket = "astute-tableau"
  acl    = "private"

  tags = {
    Name        = "astute-tableau"
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
