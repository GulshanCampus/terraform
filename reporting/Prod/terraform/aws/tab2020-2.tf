resource "aws_instance" "tab2020v4p-2" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "c5.4xlarge"
  ebs_optimized               = true
  subnet_id                   = data.aws_subnet.saas-app-subnet-1a.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2020v4p.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id

  root_block_device {
    volume_type = "gp3"
    volume_size = "500"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp3"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "tab2020v4p-2"
    Product     = var.Product
    Application = "Tableau"
    Type        = "Primary"
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "tab2020v4p-2"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
}

data "template_file" "tab2020v4w1p-2" {
  template = file("userdata/tableau.txt")

  vars = {
    hostname = "tab2020v4w1-2"
    worker   = "worker1"
  }
}

resource "aws_instance" "tab2020v4w1-2" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "c5.4xlarge"
  ebs_optimized               = true
  subnet_id                   = data.aws_subnet.saas-app-subnet-1c.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2020v4w1.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id

  root_block_device {
    volume_type = "gp3"
    volume_size = "500"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp3"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "tab2020v4w1-2"
    Application = "Tableau"
    Type        = "Worker"
    Product     = var.Product
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "tab2020v4w1-2"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
}

data "template_file" "tab2020v4w2-2" {
  template = file("userdata/tableau.txt")

  vars = {
    hostname = "tab2020v4w2-2"
    worker   = "worker2"
  }
}

resource "aws_instance" "tab2020v4w2-2" {
  ami                         = data.aws_ami.Windows-2019.image_id
  instance_type               = "c5.4xlarge"
  ebs_optimized               = true
  subnet_id                   = data.aws_subnet.saas-app-subnet-1d.id
  vpc_security_group_ids      = [data.aws_security_group.saas-access.id, aws_security_group.tableau-workload.id]
  user_data                   = data.template_file.tab2020v4w2.rendered
  associate_public_ip_address = false
  key_name                    = "SaaSOps-USE"
  iam_instance_profile        = aws_iam_instance_profile.tableau.id
  user_data_replace_on_change = false

  root_block_device {
    volume_type = "gp3"
    volume_size = "500"
  }

  ebs_block_device {
    device_name = "/dev/xvdc"
    volume_type = "gp3"
    volume_size = 175
    encrypted   = true
  }

  tags = {
    Name        = "tab2020v4w2-2"
    Product     = var.Product
    Application = "Tableau"
    Type        = "Worker"
    Environment = var.Environment
    Terraform   = var.Terraform
  }

  volume_tags = {
    Name    = "tab2020v4w2-2"
    Product = var.Product
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data
    ]
  }
}
