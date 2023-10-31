resource "aws_eip" "tableau-2020-4" {
  vpc      = true
  instance = aws_instance.tableau-2020-4.id
}

data "template_file" "tableau-2020-4" {
  template = file("userdata/tableau-2020-4.txt")
}

resource "aws_instance" "tableau-2020-4" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "m5a.2xlarge"
  subnet_id                   = data.aws_subnet.public-1d.id
  vpc_security_group_ids      = [data.aws_security_group.epc-dev.id, data.aws_security_group.reporting-beta.id, data.aws_security_group.tableau-servers.id]
  key_name                    = "aa-dev"
  associate_public_ip_address = true
  user_data                   = data.template_file.tableau-2020-4.rendered
  iam_instance_profile        = data.aws_iam_instance_profile.aa-dev.name

  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
  }

  tags = {
    Name        = "tableau-2020-4"
    Product     = "reporting"
    Environment = "Development"
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
    ]
  }
}

resource "aws_ebs_volume" "tableau-d-drive" {
  availability_zone = data.aws_subnet.public-1d.availability_zone
  type              = "gp3"
  size              = 200
}

resource "aws_volume_attachment" "tableau-d-drive" {
  device_name = "/dev/xvdc"
  instance_id = aws_instance.tableau-2020-4.id
  volume_id   = aws_ebs_volume.tableau-d-drive.id
}

resource "aws_lb" "Tableau-LB" {
  name               = "Tableau-ELB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.epc-dev.id, data.aws_security_group.reporting-beta.id, data.aws_security_group.tableau-servers.id]
  subnets            = [data.aws_subnet.public-1d.id, data.aws_subnet.public-1e.id]

  enable_deletion_protection = true
  idle_timeout               = 3600

  tags = {
    Product     = "tableau-2020-4"
    Environment = "dev"
  }
}

resource "aws_lb_listener" "HTTPs-Tableau-Listener" {
  load_balancer_arn = aws_lb.Tableau-LB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-1-2017-01"
  certificate_arn   = data.aws_acm_certificate.astutesolutions.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Tableau-DEV-TargetGroup.arn
  }
}

resource "aws_lb_target_group" "Tableau-DEV-TargetGroup" {
  name     = "HTTPS-Tableau-TargetGroup"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.vpc-Dev-Primary.id

  depends_on = [
    aws_lb.Tableau-LB
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "Tableau-DEV-TG-Attach" {
  target_group_arn = aws_lb_target_group.Tableau-DEV-TargetGroup.arn
  target_id        = "i-0a7f675519a5a08a5"
}