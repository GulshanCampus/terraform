resource "aws_instance" "early-recall-detection" {
  ami                  = data.aws_ami.Ubuntu-1804.image_id
  instance_type        = "t3.small"
  user_data            = file("userdata/recall.txt")
  subnet_id            = data.aws_subnet.public-1d.id
  iam_instance_profile = aws_iam_instance_profile.early-detection.name

  vpc_security_group_ids = [aws_security_group.early-recall-detection.id]
  key_name               = "recall-dev"

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  tags = {
    Name        = "early-recall-detection"
    Product     = var.Product
    Environment = var.Environment
    terraform   = var.Terraform
    codedeploy  = "early-recall-detection"
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}

resource "aws_eip" "early-recall-detection" {
  instance = aws_instance.early-recall-detection.id
  vpc      = true
}

resource "aws_codedeploy_app" "early-recall-detection" {
  compute_platform = "Server"
  name             = "early-recall-detection"
}

resource "aws_codedeploy_deployment_group" "early-recall-detection" {
  app_name              = aws_codedeploy_app.early-recall-detection.name
  deployment_group_name = "dev"
  service_role_arn      = "arn:aws:iam::786014450157:role/CodeDeployTrustRole"
  ec2_tag_set {
    ec2_tag_filter {
      key   = "codedeploy"
      type  = "KEY_AND_VALUE"
      value = "early-recall-detection"
    }
  }
}

