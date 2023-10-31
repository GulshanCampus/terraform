resource "aws_lb" "tableau-production" {
  name                       = "tableau-production"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.tableau-loadbalancer.id]
  subnets                    = [data.aws_subnet.saas-dmz-subnet-1a.id, data.aws_subnet.saas-dmz-subnet-1c.id, data.aws_subnet.saas-dmz-subnet-1d.id]
  idle_timeout               = 120
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.astute-tableau-lb-logs.bucket
    enabled = true
  }

  tags = {
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.tableau-production.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:156063083762:certificate/5602d9c5-7155-4d88-ba29-7a75dc610149"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tableau2020-servers.arn
  }
}

resource "aws_lb_listener" "http-redirect" {
  load_balancer_arn = aws_lb.tableau-production.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_rule" "tableau2020" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tableau2020-servers.arn
  }

  condition {
    host_header {
      values = ["tableau2020.myastutesolutions.com"]
    }
  }
}

resource "aws_lb_target_group" "tableau-servers" {
  name                 = "tableau-servers"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.astute-saas-vpc.id
  deregistration_delay = 20

  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group" "tableau2020-servers" {
  name                 = "tableau2020-servers"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.astute-saas-vpc.id
  deregistration_delay = 20

  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "tab2020p-2" {
  target_group_arn = aws_lb_target_group.tableau2020-servers.arn
  target_id        = aws_instance.tab2020v4p-2.id
}

resource "aws_lb_target_group_attachment" "tab2020w1-2" {
  target_group_arn = aws_lb_target_group.tableau2020-servers.arn
  target_id        = aws_instance.tab2020v4w1-2.id
}

resource "aws_lb_target_group_attachment" "tab2020w2-2" {
  target_group_arn = aws_lb_target_group.tableau2020-servers.arn
  target_id        = aws_instance.tab2020v4w2-2.id
}



resource "aws_lb" "early-recall" {
  name               = "early-recall"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.loadbalancer.id]
  subnets            = [data.aws_subnet.saas-dmz-subnet-1a.id, data.aws_subnet.saas-dmz-subnet-1c.id, data.aws_subnet.saas-dmz-subnet-1d.id]

  enable_deletion_protection = true

  tags = {
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }
  access_logs {
    enabled = true
    bucket  = "alb-access-logs-astute"
  }


}

resource "aws_lb_listener" "early-recall-https" {
  load_balancer_arn = aws_lb.early-recall.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:156063083762:certificate/5602d9c5-7155-4d88-ba29-7a75dc610149"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.early-recall.arn
  }
}

resource "aws_lb_listener" "early-recall-http" {
  load_balancer_arn = aws_lb.early-recall.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "early-recall" {
  name     = "early-recall"
  port     = 4399
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.astute-saas-vpc.id

  health_check {
    path     = "/health"
    port     = 4399
    protocol = "HTTP"
  }
}
