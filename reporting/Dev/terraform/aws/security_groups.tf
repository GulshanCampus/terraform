resource "aws_security_group" "early-recall-detection" {
  name        = "early-recall-detection"
  description = "basic access for early recall app"
  vpc_id      = data.aws_vpc.vpc-Dev-Primary.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.dev, var.astute_vpn, data.aws_vpc.vpc-Dev-Primary.cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.dev, var.astute_vpn, data.aws_vpc.vpc-Dev-Primary.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.dev, var.astute_vpn, data.aws_vpc.vpc-Dev-Primary.cidr_block]
  }

  ingress {
    from_port   = 4399
    to_port     = 4399
    protocol    = "tcp"
    cidr_blocks = [var.dev, var.astute_vpn, data.aws_vpc.vpc-Dev-Primary.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "tableau-servers" {
  id = "sg-09084175"
}

data "aws_security_group" "epc-dev" {
  id = "sg-13126f77"
}

data "aws_security_group" "reporting-beta" {
  id = "sg-db6ea1ab"
}