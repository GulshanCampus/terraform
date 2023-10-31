resource "aws_iam_instance_profile" "tableau" {
  name = "tableau"
  role = aws_iam_role.tableau-role.name
}

resource "aws_iam_role" "tableau-role" {
  name = "tableau-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "tableau-policy" {
  name        = "tableau-policy"
  description = "A policy for tableau to join the myastute domain"
  policy      = file("iam-policies/tableau.json")
}

resource "aws_iam_policy_attachment" "tableau-policy-attach" {
  name       = "tableau-policy-attach"
  policy_arn = aws_iam_policy.tableau-policy.arn
  roles      = [aws_iam_role.tableau-role.name]
}

data "aws_iam_instance_profile" "saasSSM" {
  name = "saasSSM"
}

resource "aws_iam_group" "astute-tableau-s3" {
  name = "tableau-s3"
}

resource "aws_iam_policy" "tableau-s3" {
  name        = "tableau-s3"
  description = "A policy for tableau to join the myastute domain"
  policy      = file("iam-policies/tableau-s3.json")
}

resource "aws_iam_policy_attachment" "tableau-s3" {
  name       = "tableau-s3"
  policy_arn = aws_iam_policy.tableau-s3.arn
  groups     = [aws_iam_group.astute-tableau-s3.name]
}

resource "aws_iam_instance_profile" "early-detection" {
  name = "early-detection"
  role = aws_iam_role.early-detection-role.name
}

resource "aws_iam_role" "early-detection-role" {
  name = "early-detection-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "early-detection-policy" {
  name        = "early-detection-policy"
  description = "A policy for tableau to join the myastute domain"
  policy      = file("iam-policies/early-detection.json")
}

resource "aws_iam_policy_attachment" "early-detection-policy-attach" {
  name       = "early-detection-policy-attach"
  policy_arn = aws_iam_policy.early-detection-policy.arn
  roles      = [aws_iam_role.early-detection-role.name]
  groups = [
    "stuteKnowledgeGlobal-BambooCodeDeployUser-5X5QKB36ITVJ",
  ]
}
