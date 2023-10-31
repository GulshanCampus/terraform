resource "aws_launch_template" "early-recall-detection" {
  name          = "early-recall-detection"
  image_id      = data.aws_ami.Ubuntu-1804.image_id
  instance_type = "t3.small"
  user_data     = base64encode(file("userdata/recall.txt"))

  iam_instance_profile {
    name = aws_iam_instance_profile.early-detection.name
  }

  key_name               = "earlyrecall"
  vpc_security_group_ids = [aws_security_group.early-recall-detection.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "early-recall-detection"
      Product     = var.Product
      Environment = var.Environment
      terraform   = var.Terraform
      codedeploy  = "early-recall-detection"
    }
  }

  lifecycle {
    ignore_changes = [
      //      latest_version,
      //      user_data,
    ]
  }
}

resource "aws_autoscaling_group" "early-recall-detection" {
  name                      = "early-recall-detection"
  min_size                  = "1"
  max_size                  = "2"
  desired_capacity          = "1"
  vpc_zone_identifier       = [data.aws_subnet.saas-app-subnet-1a.id, data.aws_subnet.saas-app-subnet-1c.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  target_group_arns         = [aws_lb_target_group.early-recall.arn]

  launch_template {
    id      = aws_launch_template.early-recall-detection.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_codedeploy_app" "early-recall-detection" {
  compute_platform = "Server"
  name             = "early-recall-detection"
}

resource "aws_codedeploy_deployment_group" "early-recall-detection" {
  app_name              = aws_codedeploy_app.early-recall-detection.name
  deployment_group_name = "prod"
  service_role_arn      = "arn:aws:iam::156063083762:role/CodeDeployTrustRole"

  deployment_config_name = "CodeDeployDefault.OneAtATime"
  autoscaling_groups     = [aws_autoscaling_group.early-recall-detection.id]

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.early-recall.name
    }
  }
}

