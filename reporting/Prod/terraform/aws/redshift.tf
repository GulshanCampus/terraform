resource "aws_redshift_subnet_group" "redshift-public" {
  name       = "redshift-public"
  subnet_ids = [data.aws_subnet.saas-dmz-subnet-1c.id, data.aws_subnet.saas-dmz-subnet-1a.id, data.aws_subnet.saas-dmz-subnet-1d.id]
}

resource "aws_redshift_cluster" "redshift-marzetti" {
  cluster_identifier                  = "redshift-marzetti"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [aws_security_group.redshift-marzetti.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

/*resource "aws_redshift_cluster" "redshift-scotts" {
  cluster_identifier                  = "redshift-scotts"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_scotts
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id]
  encrypted                           = true
  publicly_accessible                 = true
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }
} */

resource "aws_redshift_cluster" "redshift-landolakes" {
  cluster_identifier                  = "redshift-landolakes"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_landolakes
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-landolakes.id, "sg-8a6f9ee5"]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-freshpet" {
  cluster_identifier                  = "redshift-freshpet"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_freshpet
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-freshpet.id, "sg-8a6f9ee5"]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-business" {
  cluster_identifier                  = "redshift-business"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_business
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-business.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-nationwide" {
  cluster_identifier                  = "redshift-nationwide"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_nationwide
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-nationwide.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }
}


resource "aws_redshift_cluster" "redshift-wegmans" {
  cluster_identifier                  = "redshift-wegmans"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_wegmans
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-wegmans.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-omdemo" {
  cluster_identifier                  = "epc-reporting-omdemo"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_omdemo
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  automated_snapshot_retention_period = 7
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-omdemo.id]
  encrypted                           = true
  publicly_accessible                 = true

  cluster_parameter_group_name = aws_redshift_parameter_group.redshift-SSL-pg.name

  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports          = ["connectionlog", ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-tyson" {
  cluster_identifier                  = "epc-reporting-tyson"
  node_type                           = "dc2.large"
  database_name                       = "prod"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user_tyson
  master_password                     = var.redshift_password_tyson
  cluster_subnet_group_name           = "epc-reporting-smuckers-redshiftclustersubnetgroup-1amp0b7tjxoz4"
  vpc_security_group_ids              = ["sg-07ed4fcad67acebff", "sg-4be77e2f", "sg-8a6f9ee5", ]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-jetblue" {
  cluster_identifier                  = "epc-reporting-jetblue"
  node_type                           = "dc2.large"
  database_name                       = "agentanalytic"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_jetblue
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-jetblue.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-shurtape" {
  cluster_identifier                  = "epc-reporting-shurtape"
  node_type                           = "dc2.large"
  database_name                       = "agentanalytic"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_shurtape
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-shurtape.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}


resource "aws_redshift_cluster" "redshift-spot" {
  cluster_identifier                   = "spot"
  node_type                            = "dc2.large"
  availability_zone                    = "us-east-1d"
  availability_zone_relocation_enabled = false
  cluster_parameter_group_name         = "reporting-ssl-pg"
  cluster_revision_number              = "47357"
  cluster_subnet_group_name            = "spot-redshift"
  vpc_security_group_ids               = [data.aws_security_group.saas-access.id, aws_security_group.redshift-spot.id]
  database_name                        = "spot"
  master_password                      = var.redshift_password_spot
  master_username                      = var.redshift_user_spot
  skip_final_snapshot                  = true
  encrypted                            = true
  tags = {
    "Product" = "spotreporting"
  }
  tags_all = {
    "Product" = "spotreporting"
  }
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-smuckers" {
  cluster_identifier                   = "epc-reporting-smuckers"
  node_type                            = "dc2.large"
  availability_zone                    = "us-east-1a"
  availability_zone_relocation_enabled = false
  cluster_parameter_group_name         = "reporting-ssl-pg"
  cluster_revision_number              = "47357"
  cluster_subnet_group_name            = "epc-reporting-smuckers-redshiftclustersubnetgroup-1amp0b7tjxoz4"
  vpc_security_group_ids               = ["sg-9b7ecfd0"]
  database_name                        = "warehouse"
  master_password                      = var.redshift_password_smuckers
  master_username                      = var.redshift_user
  skip_final_snapshot                  = true
  encrypted                            = true
  tags = {
    "Product" = "reporting"
  }
  tags_all = {
    "Product" = "reporting"
  }
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}


resource "aws_redshift_cluster" "redshift-PMI" {
  cluster_identifier                  = "epc-reporting-pmi"
  node_type                           = "dc2.large"
  database_name                       = "agentanalytic"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_pmi
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-pmi.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-coty" {
  cluster_identifier                  = "epc-reporting-coty"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_coty
  cluster_subnet_group_name           = "epc-reporting-smuckers-redshiftclustersubnetgroup-1amp0b7tjxoz4"
  vpc_security_group_ids              = [aws_security_group.redshift-coty.id]
  encrypted                           = false
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_coty.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-rptredshiftcluster" {
  cluster_identifier                  = "epc-reporting-rptredshiftcluster-1b4ci2trpknjc"
  node_type                           = "ds2.xlarge"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user_rptredshiftcluster
  master_password                     = var.redshift_password_rptredshiftcluster
  cluster_subnet_group_name           = "epc-reporting-rptredshiftclustersubnetgroup-1srtv7u7nws8t"
  vpc_security_group_ids              = [aws_security_group.redshift-rptredshiftcluster.id]
  encrypted                           = true
  publicly_accessible                 = false
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  tags = {
    "Product" = "reporting"
    "product" = "reporting"
  }
  tags_all = {
    "Product" = "reporting"
    "product" = "reporting"
  }
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password, database_name]
  }
}

resource "aws_redshift_cluster" "redshift-bots-reporting" {
  cluster_identifier                  = "bots-reporting"
  node_type                           = "dc2.large"
  database_name                       = "dev"
  cluster_type                        = "multi-node"
  master_username                     = var.redshift_user_bots_reporting
  master_password                     = var.redshift_password_bots_reporting
  cluster_subnet_group_name           = "bots-reporting"
  vpc_security_group_ids              = [aws_security_group.redshift-bots-reporting.id]
  encrypted                           = false
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  number_of_nodes                     = 2
  skip_final_snapshot                 = true
  tags = {
    "Product" = "astutebot"
  }
  tags_all = {
    "Product" = "astutebot"
  }
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",

    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-astuteagent-advanced-reporting" {
  cluster_identifier                  = "astuteagent-advanced-reporting"
  node_type                           = "dc2.large"
  database_name                       = "reporting"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user_astuteagent-advanced-reporting
  master_password                     = var.redshift_password_astuteagent-advanced-reporting
  cluster_subnet_group_name           = "epc-reporting-estee-redshiftclustersubnetgroup-1ncvvvwv4jtdy"
  vpc_security_group_ids              = [aws_security_group.redshift-astuteagent-advanced-reporting.id]
  encrypted                           = true
  publicly_accessible                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  skip_final_snapshot                 = true
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",

    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-dominos" {
  cluster_identifier                  = "epc-reporting-dominos"
  node_type                           = "dc2.large"
  database_name                       = "agentanalytic"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_dominos
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-dominos.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_dominos.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-edgewell" {
  cluster_identifier                  = "epc-reporting-edgewell"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_edgewell
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-edgewell.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_edgewell.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-duracell" {
  cluster_identifier                  = "epc-reporting-duracell"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_duracell
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-duracell.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-scj" {
  cluster_identifier                  = "epc-reporting-scj"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_scj
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-scj.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_scj.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-trident" {
  cluster_identifier                  = "epc-reporting-trident"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_trident
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-trident.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_trident.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-aerlingus" {
  cluster_identifier                  = "epc-reporting-aerlingus"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_aerlingus
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-aerlingus.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_aerlingus.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }

  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-smithfield" {
  cluster_identifier                  = "epc-reporting-smithfield"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_smithfield
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-smithfield.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_smithfield.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-bigelow" {
  cluster_identifier                  = "epc-reporting-bigelow"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_bigelow
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-bigelow.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_bigelow.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }
}
resource "aws_redshift_cluster" "redshift-butterball" {
  cluster_identifier                  = "epc-reporting-butterball"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_butterball
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-butterball.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_butterball.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }
}

resource "aws_redshift_cluster" "redshift-hillpets" {
  cluster_identifier                  = "epc-reporting-hillpets"
  node_type                           = "dc2.large"
  database_name                       = "warehouse"
  cluster_type                        = "single-node"
  master_username                     = var.redshift_user
  master_password                     = var.redshift_password_hillpets
  cluster_subnet_group_name           = aws_redshift_subnet_group.redshift-public.name
  vpc_security_group_ids              = [data.aws_security_group.saas-access.id, aws_security_group.redshift-hillpets.id]
  encrypted                           = true
  publicly_accessible                 = true
  skip_final_snapshot                 = true
  cluster_parameter_group_name        = aws_redshift_parameter_group.redshift-SSL-pg.name
  automated_snapshot_retention_period = 7
  elastic_ip                          = aws_eip.redshift_eip_hillpets.public_ip
  logging {
    enable               = true
    log_destination_type = "cloudwatch"
    log_exports = [
      "connectionlog",
      "useractivitylog",
      "userlog",
    ]
  }
  lifecycle {
    ignore_changes = [master_password]
  }


}