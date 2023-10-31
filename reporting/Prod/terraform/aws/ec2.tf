resource "aws_instance" "pcas-logging" {
  ami           = data.aws_ami.Windows-2019.image_id
  instance_type = "t2.small"

  user_data            = file("userdata/pcas-logging.txt")
  iam_instance_profile = "saasSSM"
  subnet_id            = data.aws_subnet.saas-dmz-subnet-1c.id

  vpc_security_group_ids      = [aws_security_group.pcas-logging.id]
  key_name                    = "SaaSOps-USE"
  user_data_replace_on_change = false
  root_block_device {
    volume_type = "gp3"
    volume_size = "50"
  }

  tags = {
    Name        = "pcas-logging"
    Function    = "Grant access to pcas logs"
    Product     = var.Product
    Environment = "Prod"
    terraform   = "epowercenter/Prod/terraform/"
  }

  volume_tags = {
    Name    = "pcas-logging"
    Product = "epowercenter"
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}

resource "aws_eip" "pcas-logging" {
  instance = aws_instance.pcas-logging.id
  vpc      = true
}

resource "aws_instance" "aspire-vpn" {
  ami           = data.aws_ami.Ubuntu-1804.image_id
  instance_type = "t3.medium"

  iam_instance_profile = "saasSSM"
  subnet_id            = data.aws_subnet.saas-dmz-subnet-1c.id

  vpc_security_group_ids      = [aws_security_group.aspire-vpn.id]
  key_name                    = "devops"
  user_data_replace_on_change = false
  root_block_device {
    volume_type = "gp3"
    volume_size = "20"
  }

  tags = {
    Name        = "aspire-vpn"
    Function    = "aspire vpn for macroengine access"
    Product     = var.Product
    Environment = "Prod"
    terraform   = "epowercenter/Prod/terraform/"
  }

  volume_tags = {
    Name    = "aspire-vpn"
    Product = "epowercenter"
  }


  lifecycle {
    ignore_changes = [ami, user_data]
  }
}

resource "aws_eip" "aspire-vpn" {
  instance = aws_instance.aspire-vpn.id
  vpc      = true
  tags = {
    Name = "ASPIRE VPN EIP ATTACHED"
  }
}

/*resource "aws_eip" "aspire-vpn-alt" {
  vpc = true
  tags = {
    Name = "ASPIRE VPN EIP DO NOT ATTACH"
  }
}*/
