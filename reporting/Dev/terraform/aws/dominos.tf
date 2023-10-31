resource "aws_iam_user" "dominos-upload" {
  name = "dominos-upload"
}

resource "aws_iam_policy" "dominos-upload" {
  name        = "dominos-upload"
  description = "A policy for Dominos to upload database backups"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::${var.rpt_database_uploads}",
            "Condition": {
                "StringLike": {
                    "s3:prefix": "dominos/"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.rpt_database_uploads}/dominos/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "dominos-upload" {
  policy_arn = aws_iam_policy.dominos-upload.arn
  user       = aws_iam_user.dominos-upload.name
}