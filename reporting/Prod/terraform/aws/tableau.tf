############
#### 2019-4
############

data "template_file" "tab2019v4-primary" {
  template = file("userdata/tableau.txt")

  vars = {
    hostname = "Tab2019v4-Primary"
    worker   = "primary"
  }
}

/*resource "aws_instance" "tab2019v4-primary" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "m5.2xlarge"
  subnet_id                   = data.aws_subnet.saas-app-subnet-1a.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2019v4-primary.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id

  root_block_device {
    volume_type = "gp2"
    volume_size = "150"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp2"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "Tab2019v4-Primary"
    Product     = var.Product
    Application = "Tableau"
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "Tab2019v4-Primary"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
}*/

data "template_file" "tab2019v4-worker1" {
  template = file("userdata/tableau.txt")

  vars = {
    hostname = "Tab2019v4-Worker1"
    worker   = "worker1"
  }
}

/*resource "aws_instance" "tab2019v4-worker1" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "m5.2xlarge"
  subnet_id                   = data.aws_subnet.saas-app-subnet-1c.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2019v4-worker1.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id

  root_block_device {
    volume_type = "gp2"
    volume_size = "75"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp2"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "Tab2019v4-Worker1"
    Application = "Tableau"
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "Tab2019v4-Worker1"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
}*/

data "template_file" "tab2019v4-worker2" {
  template = file("userdata/tableau.txt")

  vars = {
    hostname = "Tab2019v4-Work2"
    worker   = "worker2"
  }
}

/*resource "aws_instance" "tab2019v4-worker2" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "m5.2xlarge"
  subnet_id                   = data.aws_subnet.saas-app-subnet-1d.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2019v4-worker2.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id

  root_block_device {
    volume_type = "gp2"
    volume_size = "75"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp2"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "Tab2019v4-Worker2"
    Product     = var.Product
    Application = "Tableau"
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "Tab2019v4-Worker2"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
} */
