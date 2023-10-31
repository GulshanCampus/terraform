data "aws_security_group" "saas-access" {
  id = "sg-4be77e2f"
}

resource "aws_security_group" "tableau-workload" {
  name        = "tableau-workload"
  description = "allow traffic between hosts"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description     = ""
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
    security_groups = [aws_security_group.tableau-loadbalancer.id]
  }

  egress {
    description = ""
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = false
    cidr_blocks = ["24.235.157.59/32"]
  }

  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "tableau-loadbalancer" {
  name        = "tableau-loadbalancer"
  description = "Allow HTTPS Traffic"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = "open https "
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = ""
    from_port   = 8850
    to_port     = 8850
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "restricted temp"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.200.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "pcas-logging" {
  name        = "pcas-logging"
  description = "rdp access for devs to look at logs"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aspire-vpn" {
  name        = "aspire-vpn"
  description = "aspire vpn to access macro engine"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.200.0.0/16", "195.68.186.82/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.200.0.0/16", "4.7.156.50/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "early-recall-detection" {
  name        = "early-recall-detection"
  description = "basic access for early recall app"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 4399
    to_port     = 4399
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 4399
    to_port     = 4399
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "loadbalancer" {
  name        = "loadbalancer"
  description = "Allow HTTPS Traffic"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-coty" {
  name        = "EPC-Reporting-Coty-RedshiftSecurityGroup"
  description = "Customer IPs to access Redshift"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id
  tags = {
    Name    = "SaaS-Rpt Servers can access Redshift"
    Product = "reporting"
  }
  tags_all = {
    Name    = "SaaS-Rpt Servers can access Redshift"
    Product = "reporting"
  }

  ingress {
    description = "DEVOPS-22704"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["172.28.126.6/32"]
  }

  ingress {
    description = "DEVOPS-22701"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["147.161.231.74/32"]
  }


  ingress {
    description = "adnan-temp"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["39.34.152.156/32"]
  }
  ingress {
    description = "DEV AWS VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.86.41.133/32"]
  }
  ingress {
    description = "NAT Gateway"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
  }

  ingress {
    description = "Office IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["4.7.156.50/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }


  ingress {
    description = "snuckers provided ip (02-09-2022)"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.2.16.63/32"]
  }

  ingress {
    description = "VPC CIDR Block"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.200.0.0/16"]
  }

  ingress {
    description = "Smuckers provided IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["198.179.173.2/32",
      "198.179.173.3/32",
      "52.14.41.21/32",
      "52.14.23.11/32",
    "18.224.154.142/32", ]
  }

  ingress {
    description = "Tableau Desktop"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["3.234.90.136/32"]
  }

  ingress {
    description = "DEVOPS-19948"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["198.203.169.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "redshift-marzetti" {
  description = "Access to RDP/SSH/Etc from trusted networks"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks = [
        "10.122.0.0/16",
      ]
      description      = "Idera SQL safe"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
        "10.210.0.0/16",
        "10.220.0.0/16",
        "10.230.0.0/16",
        "10.200.0.0/24",
        "10.60.31.25/32",
      ]
      description      = ""
      from_port        = -1
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
      ]
      description      = "winrm -access"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5985
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
      ]
      description      = "workspace rdp"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "10.200.0.168/32",
      ]
      description      = "Baidy"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.150.147/32",
      ]
      description      = "tableau server"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.252.200/32",
      ]
      description      = "awswitness"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.254.23/32",
      ]
      description      = "sql-prod"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.254.31/32",
      ]
      description      = "RDP to use203"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5985
    },
    {
      cidr_blocks = [
        "10.205.0.0/16",
      ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks = [
        "10.60.31.25/32",
        "4.7.156.50/32",
        "52.86.41.133/32",
        "10.200.0.0/16",
        "208.127.240.21/32",
        "34.100.0.0/16",
        "208.127.245.228/32",
      ]
      description      = ""
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids = [
        "pl-0d36adcc4ea9c3e57",
      ]
      protocol        = "tcp"
      security_groups = []
      self            = false
      to_port         = 5439
    },
    {
      cidr_blocks = [
        "103.72.87.0/24",
      ]
      description      = "adnan-temp"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "192.168.10.0/24",
        "192.168.191.0/24",
        "192.168.0.0/24",
        "10.200.252.0/22",
        "10.210.252.0/22",
        "10.220.252.0/22",
        "10.230.252.0/22",
        "192.168.40.0/24",
        "10.200.0.0/16",
        "172.20.2.33/32",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups = [
        "sg-b547cacc",
        "sg-d5f52bb3",
      ]
      self    = false
      to_port = 0
    },
    {
      cidr_blocks = [
        "198.37.133.30/32",
      ]
      description      = "devops-18424"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "3.234.90.136/32",
      ]
      description      = "Tableau Desktop Server"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.4.156.50/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "4.4.156.50/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.4.57.6/32",
        "10.200.2.217/32",
      ]
      description      = ""
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "52.232.228.241/32",
      ]
      description      = "devops 17920"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "52.87.51.15/32",
      ]
      description      = "prinit"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "aws witness dns"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 53
    },
    {
      cidr_blocks      = []
      description      = "aws witness"
      from_port        = 4505
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 4506
    },
    {
      cidr_blocks      = []
      description      = "awswitness dns2"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 53
    },
    {
      cidr_blocks      = []
      description      = "for awswitness test"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 0
    },
    {
      cidr_blocks = []
      description = "ne1"
      from_port   = 80
      ipv6_cidr_blocks = [
        "::/0",
      ]
      prefix_list_ids = []
      protocol        = "tcp"
      security_groups = []
      self            = false
      to_port         = 80
    },
    {
      cidr_blocks      = []
      description      = "winrm for aws witness"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 5985
    },
  ]
  name = "SaaS-Access-marzetti"
  tags = {
    "Name" = "redshift-marzetti"
  }
  tags_all = {
    "Name" = "redshift-marzetti"
  }
  vpc_id = "vpc-e0a6ad8a"

  timeouts {}
}

resource "aws_security_group" "redshift-business" {
  name        = "redshift-business"
  description = "redshift for business system"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn]
    description = "Office VPN"
  }

  ingress {
    description = "DEV AWS VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.85.41.133/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.astute-saas-vpc.cidr_block]
    description = "VPC CIDR"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.dev_vpn]
    description = "Dev VPN"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
    description = "Workspaces"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["54.71.48.41/32", "52.13.34.156/32", "52.39.185.156/32", "44.230.35.207/32", "35.164.143.139/32", "34.217.248.107/32"]
    description = "SB Datalake Team"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-landolakes" {
  name        = "redshift-landolakes"
  description = "redshift for landolakes system"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = "USERPTETL1A"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
  }

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, var.dev_vpn, "173.255.80.10/32", "173.255.92.10/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["173.255.80.50/32", "173.255.80.51/32", "173.255.80.52/32", "173.255.80.53/32", "173.255.92.50/32", "173.255.92.51/32", "173.255.92.52/32", "173.255.92.53/32"]
    description = "Customer IPs - DEVOPS-15047"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-omdemo" {
  name        = "redshift-omdemo"
  description = "redshift for omdemo"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, "173.255.80.10/32", "173.255.92.10/32", "10.0.2.0/24", "10.0.1.0/24"]
  }

  ingress {
    description = "DEVOPS-21338"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.208.254.117/32", "46.137.149.172/32", "52.19.37.233/32", ]
  }

  ingress {
    description = "DEVOPS-21351"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["93.36.218.250/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "DEVOPS-20923 - Trident"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["65.120.208.98/32"]
  }


  ingress {
    description = "florian ip"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }

  ingress {
    description = "DEVOPS-21206"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["92.135.127.60/32"]
  }
  ingress {
    description = "DEVOPS-21336"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["208.127.126.48/28"]
  }

  ingress {
    description = "DEVOPS-21211"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["165.1.195.56/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-jetblue" {
  name        = "redshift-jetblue"
  description = "redshift for jetblue"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, "173.255.80.10/32", "173.255.92.10/32"]
  }

  ingress {
    description = "DEVOPS-22779"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["134.238.204.101/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Customer IP DEVOPS-22726"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["64.25.25.249/32"]
  }

  ingress {
    description = "Customer IP DEVOPS-21081"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.151.226.56/32"]
  }

  ingress {
    description = "DEVOPS-21530"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["137.83.219.162/32"]
  }

  ingress {
    description = "DEVOPS-22779"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["134.238.204.101/32"]
  }

  ingress {
    description = "DEVOPS-24200"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["165.1.207.150/32", "165.1.207.212/32", "134.238.182.95/32", "137.83.217.130/32", "137.83.217.144/32", "134.238.183.200/32", "165.85.44.131/32", "165.85.44.132/32", "165.85.44.133/32", "165.85.44.134/32", "165.85.44.135/32", "165.85.44.136/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-nationwide" {
  name        = "redshift-nationwide"
  description = "redshift for nationwide system"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn]
    description = "Office VPN"
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.astute-saas-vpc.cidr_block]
    description = "VPC CIDR"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.dev_vpn]
    description = "Dev VPN"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["155.188.0.0/16"]
    description = "DEVOPS-24191"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
    description = "Workspaces"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["104.225.160.0/19", "209.249.51.0/24", "97.64.48.0/20", "149.19.32.0/19", "209.249.55.0/24", "208.185.3.0/24", "65.151.4.0/25", "136.228.192.0/18", "209.249.226.0/24", "138.43.96.0/20", "3.22.145.222/32", "52.224.186.210/32", "18.214.78.173/32", "3.22.190.185/32", "18.214.146.239/32", "52.15.83.220/32", "18.213.201.143/32", "18.215.214.157/32", "1.155.0.0/16", "155.188.123.0/24", ]
    description = "Nationwide"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.248.36.0/22", "10.248.40.0/22", "10.248.44.0/22", "10.249.36.0/22", "10.249.40.0/22", "10.249.44.0/22", "34.225.207.47/32", "44.206.61.118/32", "54.145.182.249/32", "3.136.209.10/32", "3.140.52.241/32", "18.217.27.67/32", ]
    description = "Nationwide DEVOPS-19533"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["104.129.192.0/20", "136.226.0.0/16", "137.83.128.0/18", "147.161.128.0/17", "165.225.0.0/17", "165.225.192.0/18", "167.103.0.0/16", "170.85.0.0/16", "185.46.212.0/22", "199.168.148.0/22"]
    description = "Nationwide DEVOPS-24258"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###

resource "aws_security_group" "redshift-wegmans" {
  name        = "redshift-wegmans"
  description = "redshift for wegmans system"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id



  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.astute-saas-vpc.cidr_block]
    description = "VPC CIDR"
  }


  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
    description = "Workspaces"
  }

  #IPs needs to confirm from customer.
  ingress {
    from_port = 5439
    to_port   = 5439
    protocol  = "tcp"
    #cidr_blocks = ["65.151.4.0/25", "97.64.48.0/20", "104.225.160.0/19", "136.228.192.0/18", "138.43.96.0/20", "149.19.32.0/19", "208.185.3.0/24", "209.249.51.0/24", "209.249.55.0/24", "209.249.226.0/24", "155.188.0.0/16", "18.213.201.143/32", "18.214.78.173/32", "18.214.146.239/32", "3.22.145.222/32", "3.22.190.185/32", "52.15.83.220/32", "52.224.186.210/32", "18.215.214.157/32"]
    cidr_blocks = ["207.138.79.16/32", "207.138.79.0/24", "74.39.145.0/24", "142.202.144.0/24"]
    description = "wegmans"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["172.28.47.248/32", "172.28.46.1/32", "172.26.116.75/32", "172.28.47.249/32", ]
    description = "wegmans"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["20.14.229.7/32", "20.94.25.1/32", "20.22.40.135/32", "20.22.42.64/32"]
    description = "Customer IPs - DEVOPS-20662"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "redshift-tyson" {
  name                   = "redshift-business"
  description            = "redshift for business system"
  vpc_id                 = data.aws_vpc.astute-saas-vpc.id
  revoke_rules_on_delete = false
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn]
    description = "Office VPN"
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.astute-saas-vpc.cidr_block]
    description = "VPC CIDR"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.dev_vpn]
    description = "Dev VPN"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.85.41.133/32"]
    description = "DEV AWS VPN"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.13.34.156/32", "35.164.143.139/32", "52.39.185.156/32", "44.230.35.207/32", "34.217.248.107/32", "54.71.48.41/32"]
    description = "SB Datalake Team"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["199.66.3.4/32", "198.133.192.21/32", "199.66.3.3/32", "137.83.245.226/32", "130.41.251.95/32", "208.127.88.235/32", "137.83.219.23/32", "134.238.191.111/32", "137.83.219.23/32", "134.238.170.60/32", "134.238.195.72/32"]
    description = "DEVOPS-23814"
  }

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
    description = "Workspaces"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-shurtape" {
  name        = "redshift-shurtape"
  description = "redshift for shurtape"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "DEVOPS-22693"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["3.219.176.16/28"]
  }

  ingress {
    description = "Florians IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }

  ingress {
    description = "DEVOPS-21483"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.86.41.133/32"]
  }

  ingress {
    description = "DEVOPS-21316"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["63.163.160.230/32"]
  }

  ingress {
    description = "DEVOPS-22908"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["4.35.113.64/29", "162.155.244.240/29", "63.163.160.0/24", "4.2.115.144/29", "71.81.8.200/29"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-freshpet" {
  name        = "redshift-freshpet"
  description = "redshift for freshpet"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "DEVOPS-24243"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["190.131.250.10/32", "190.242.39.173/32", "181.49.172.149/32", "190.242.110.90/32", "20.241.251.205/32", "20.241.254.65/32", "20.241.248.162/32"]
  }

  ingress {
    description = "DEVOPS-26879"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["192.168.180.220/32"]
  }

  ingress {
    description = "DEVOPS-24549"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["192.168.180.199/32"]
  }

  ingress {
    description = "DEVOPS-24275"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["12.234.152.146/32", "50.248.134.227/32", "108.179.53.2/32"]
  }

  ingress {
    description = "DEVOPS-24721"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.170/32", "72.94.47.179/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-spot" {
  name        = "spot-redshift-firehose"
  description = "All traffic for spot"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = "DEV AWS VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.86.41.133/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.200.0.0/16",
      "4.7.156.50/32",
      "52.87.51.15/32",
    "52.70.63.192/27", ]
  }
}

resource "aws_security_group" "redshift-smuckers" {
  name        = "EPC-Reporting-Smuckers-RedshiftSecurityGroup-12GHA1F1LLUCE"
  description = "Customer IPs to access Redshift"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id
  tags = {
    Name    = "SaaS-Rpt Servers can access Redshift"
    Product = "reporting"
  }
  tags_all = {
    Name    = "SaaS-Rpt Servers can access Redshift"
    Product = "reporting"
  }
  ingress {
    description = "DEVOPS-25887"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.86.41.133/32"]
  }
  ingress {
    description = "DEVOPS-24704"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["3.13.146.35/32", "13.59.108.114/32", "3.132.152.132/32"]
  }
  ingress {
    description = "DEV AWS VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.85.41.133/32"]
  }
  ingress {
    description = "NAT Gateway"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.87.51.15/32"]
  }

  ingress {
    description = "Office IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["4.7.156.50/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }


  ingress {
    description = "snuckers provided ip (02-09-2022)"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.2.16.63/32"]
  }

  ingress {
    description = "VPC CIDR Block"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.200.0.0/16"]
  }

  ingress {
    description = "Smuckers provided IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["198.179.173.2/32",
      "198.179.173.3/32",
      "52.14.41.21/32",
      "52.14.23.11/32",
    "18.224.154.142/32", ]
  }

  ingress {
    description = "Tableau Desktop"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["3.234.90.136/32"]
  }

  ingress {
    description = "DEVOPS-19948"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["198.203.169.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-pmi" {
  name        = "redshift-pmi"
  description = "redshift for Philip Morris International"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "devops-21421"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.208.254.117/32", "46.137.149.172/32", "52.19.37.233/32", "208.127.126.0/24", "208.127.126.0/32", "93.36.218.250/32", ]
  }

  ingress {
    description = "DEVOPS-21397"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["134.238.226.0/24", "195.250.90.129/32", ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Florians IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-rptredshiftcluster" {
  description = "Access to RDP/SSH/Etc from trusted networks"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },
    {
      cidr_blocks = [
        "10.200.254.31/32",
      ]
      description      = "use203a"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },

    {
      cidr_blocks = [
        "10.122.0.0/16",
      ]
      description      = "Idera SQL safe"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
        "10.210.0.0/16",
        "10.220.0.0/16",
        "10.230.0.0/16",
        "10.200.0.0/24",
        "10.60.31.25/32",
      ]
      description      = ""
      from_port        = -1
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "icmp"
      security_groups  = []
      self             = false
      to_port          = -1
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
      ]
      description      = "winrm -access"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5985
    },
    {
      cidr_blocks = [
        "10.200.0.0/16",
      ]
      description      = "workspace rdp"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "10.200.0.168/32",
      ]
      description      = "Baidy"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.150.147/32",
      ]
      description      = "tableau server"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.252.200/32",
      ]
      description      = "awswitness"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.254.23/32",
      ]
      description      = "sql-prod"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.254.31/32",
      ]
      description      = "RDP to use203"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5985
    },
    {
      cidr_blocks = [
        "10.205.0.0/16",
      ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks = [
        "10.60.31.25/32",
        "4.7.156.50/32",
        "52.86.41.133/32",
        "10.200.0.0/16",
        "208.127.240.21/32",
        "34.100.0.0/16",
        "208.127.245.228/32",
      ]
      description      = ""
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids = [
        "pl-0d36adcc4ea9c3e57",
      ]
      protocol        = "tcp"
      security_groups = []
      self            = false
      to_port         = 5439
    },
    {
      cidr_blocks = [
        "103.72.87.0/24",
      ]
      description      = "adnan-temp"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "192.168.10.0/24",
        "192.168.191.0/24",
        "192.168.0.0/24",
        "10.200.252.0/22",
        "10.210.252.0/22",
        "10.220.252.0/22",
        "10.230.252.0/22",
        "192.168.40.0/24",
        "10.200.0.0/16",
        "172.20.2.33/32",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups = [
        "sg-b547cacc",
        "sg-d5f52bb3",
      ]
      self    = false
      to_port = 0
    },
    {
      cidr_blocks = [
        "198.37.133.30/32",
      ]
      description      = "devops-18424"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "3.234.90.136/32",
      ]
      description      = "Tableau Desktop Server"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.4.156.50/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "4.4.156.50/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.4.57.6/32",
        "10.200.2.217/32",
      ]
      description      = ""
      from_port        = 3389
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3389
    },
    {
      cidr_blocks = [
        "52.232.228.241/32",
      ]
      description      = "devops 17920"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "aws witness dns"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 53
    },
    {
      cidr_blocks      = []
      description      = "aws witness"
      from_port        = 4505
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 4506
    },
    {
      cidr_blocks      = []
      description      = "awswitness dns2"
      from_port        = 53
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "udp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 53
    },
    {
      cidr_blocks      = []
      description      = "for awswitness test"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 0
    },
    {
      cidr_blocks = []
      description = "ne1"
      from_port   = 80
      ipv6_cidr_blocks = [
        "::/0",
      ]
      prefix_list_ids = []
      protocol        = "tcp"
      security_groups = []
      self            = false
      to_port         = 80
    },
    {
      cidr_blocks      = []
      description      = "winrm for aws witness"
      from_port        = 5985
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups = [
        "sg-04b9446b",
      ]
      self    = false
      to_port = 5985
    },
  ]
  name = "SaaS-Access"
  tags = {
    "Name" = "rptredshiftcluster-sg"
  }
  tags_all = {
    "Name" = "rptredshiftcluster-sg"
  }
  vpc_id = "vpc-e0a6ad8a"

  timeouts {}
}

resource "aws_security_group" "redshift-bots-reporting" {
  name        = "default"
  description = "default VPC security group"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "10.122.2.99/32",
      ]
      description      = "DMS Replication instance 1d"
      from_port        = 1433
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 1433
    },

    {
      cidr_blocks = [
        "10.122.3.0/24",
        "10.122.4.0/24",
        "52.70.63.192/27",
        "10.122.5.0/24",
        "10.200.254.81/32",
        "10.122.6.0/24",
        "10.122.2.0/24",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.0.0/24",
        "52.87.51.15/32",
      ]
      description      = "Workspaces"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.100.0/24",
        "3.234.90.136/32",
      ]
      description      = "Tableau"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks = [
        "10.200.2.0/24",
      ]
      description      = "Workspaces 1c"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.253.10/32",
        "10.200.252.10/32",
      ]
      description      = "SaaS Monitoring"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "10.200.254.31/32",
        "10.200.254.30/32",
        "10.200.252.30/32",
      ]
      description      = "SaaS DC"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "168.151.25.31/32",
      ]
      description      = "Iperceptions NAT"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "3.85.68.20/32",
        "34.203.100.251/32",
      ]
      description      = "Social VPC NATs"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "34.203.100.251/32",
        "3.85.68.20/32",
      ]
      description      = "Social VPC NATs"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks = [
        "34.232.29.175/32",
      ]
      description      = "Social Dev Server (for solr access)"
      from_port        = 8983
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8983
    },
    {
      cidr_blocks = [
        "34.238.93.154/32",
      ]
      description      = ""
      from_port        = 1433
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 1433
    },
    {
      cidr_blocks = [
        "4.4.57.6/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks = [
        "50.112.191.121/32",
        "50.112.189.139/32",
        "52.57.142.168/32",
        "52.57.165.92/32",
        "194.213.48.4/32",
        "193.86.29.132/32",
        "18.196.168.92/32",
        "50.112.190.88/32",
      ]
      description      = ""
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks = [
        "52.13.34.156/32",
      ]
      description      = "SocialBakers Tunnel"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks = [
        "52.86.41.133/32",
      ]
      description      = ""
      from_port        = 8983
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 8983
    },
    {
      cidr_blocks = [
        "52.86.41.133/32",
      ]
      description      = "AWS VPN"
      from_port        = 1433
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 1433
    },
    {
      cidr_blocks = [
        "52.86.41.133/32",
      ]
      description      = "AWS VPN"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks = [
        "52.86.41.133/32",
      ]
      description      = "AWS VPN"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
  ]
  tags     = {}
  tags_all = {}
  vpc_id   = "vpc-53b91f3b"

  timeouts {}
}

resource "aws_security_group" "redshift-astuteagent-advanced-reporting" {
  name        = "AstuteReporting-CommunityTransit-Redshift"
  description = "AstuteReporting-CommunityTransit-Redshift"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "10.200.0.0/16",
      ]
      description      = "VPC CIDR Block"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "206.208.64.20/32",
        "206.208.64.41/32",
      ]
      description      = "Community Transit provided IP"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "3.234.90.136/32",
      ]
      description      = "Tableau Desktop"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.4.156.50/32",
      ]
      description      = "Easton Office VPN"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "4.7.156.50/32",
      ]
      description      = "Office IP"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "52.87.51.15/32",
      ]
      description      = "NAT Gateway"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },
    {
      cidr_blocks = [
        "52.86.41.133/32",
      ]
      description      = "DEV AWS VPN"
      from_port        = 5439
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5439
    },

  ]
  tags = {
    "Name" = "AstuteReporting-CommunityTransit-Redshift"
  }
  tags_all = {
    "Name" = "AstuteReporting-CommunityTransit-Redshift"
  }
  vpc_id = "vpc-e0a6ad8a"

  timeouts {}
}

resource "aws_security_group" "redshift-dominos" {
  name        = "redshift-dominos"
  description = "redshift sg for dominos"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Florians IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }
  ingress {
    description = "DEVOPS-23217"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["63.234.241.229/32"]
  }
  ingress {
    description = "DEVOPS-23217"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["65.119.145.130/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-edgewell" {
  name        = "redshift-edgewell"
  description = "redshift sg for edgewell"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "DEVOPS-23162"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.251.73.213/32"]
  }

  ingress {
    description = "DEVOPS-23109"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["165.225.61.80/32", "169.128.32.99/32"]
  }

  ingress {
    description = "DEVOPS-22763"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["165.225.61.60/32"]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Florians IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }
  ingress {
    description = "DEVOPS-21509"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [
      "20.41.2.0/23",
      "20.98.198.224/29",
      "20.44.17.80/28",
      "20.41.4.0/26",
      "40.70.148.160/28",
      "2.167.107.224/28",
      "20.49.102.16/29",
      "20.98.195.172/32",
    ]
    ipv6_cidr_blocks = [
      "2603:1030:40c:1::700/121",
      "2603:1030:40c:1::780/122",
      "2603:1030:40c:802::210/124",
      "2603:1030:40c:402::330/124",
      "2603:1030:40c:1::480/121",
      "2603:1030:40c:c02::210/124",
      "2603:1030:40c:1::500/122",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-duracell" {
  name        = "redshift-duracell"
  description = "redshift sg for duracell"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "DEVOPS-23210"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["40.86.84.179/32"]
  }
  ingress {
    description = "DEVOPS-23210"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["20.80.29.80/32"]
  }
  ingress {
    description = "DEVOPS-23210"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["20.203.145.101/32"]
  }
  ingress {
    description = "DEVOPS-23210"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["13.76.97.87/32"]
  }
  ingress {
    description = "DEVOPS-23210"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["104.211.200.160/32"]
  }
  ingress {
    description = "Florians IP"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["90.55.67.246/32"]
  }
  ingress {
    description = "DEVOPS-23496"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["96.32.10.154/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-scj" {
  name        = "redshift-scj"
  description = "redshift sg for SC Johnson"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-trident" {
  name        = "redshift-trident"
  description = "redshift sg for Trident"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "DEVOPS-23764"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["65.120.208.98/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "redshift-aerlingus" {
  name        = "redshift-aerlingus"
  description = "redshift sg for Aerlingus"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Customer IPs DEVOPS-24713"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["86.47.121.38/32"]
  }

  ingress {
    description = "Customer IPs DEVOPS-27299"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["89.19.67.208/32"]
  }

  ingress {
    description = "Customer Office IPs DEVOPS-26597"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["86.47.121.81/32", "86.47.121.71/32"]
  }

  ingress {
    description = "Customer VPN IPs DEVOPS-26597"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["86.47.121.16/32", "86.47.121.39/32"]
  }

  ingress {
    description = "Customer IP DEVOPS-27202"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["64.43.165.69/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-smithfield" {
  name        = "redshift-smithfield"
  description = "redshift sg for Smithfield"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id
  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "devops-24860"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["52.146.44.179/32"]
  }

  ingress {
    description = "devops-25203"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["10.201.16.187/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-bigelow" {
  name        = "redshift-bigelow"
  description = "redshift sg for Bigelow"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn, ]
  }

  ingress {
    description = "Easton Office VPN"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.easton_vpn]
  }

  ingress {
    description = "Customer IPs DEVOPS-27246"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["45.62.183.79/32", "45.62.183.16/32", "45.62.178.108/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-butterball" {
  name        = "redshift-butterball"
  description = "redshift for butterball"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redshift-hillpets" {
  name        = "redshift-hillpets"
  description = "redshift for hillpets"
  vpc_id      = data.aws_vpc.astute-saas-vpc.id

  ingress {
    description = ""
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.astute_vpn, data.aws_vpc.astute-saas-vpc.cidr_block, var.dev_vpn]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

