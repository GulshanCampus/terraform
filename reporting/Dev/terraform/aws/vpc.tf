data "aws_vpc" "vpc-Dev-Primary" {
  id = "vpc-20ca9345"
}

data "aws_subnet" "public-1e" {
  id = "subnet-914660ab"
}

data "aws_subnet" "public-1d" {
  id = "subnet-873e8eac"
}