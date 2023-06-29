data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_vpc" "default" {
  default = true
  state   = "available"
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "subnet_a" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-west-2a"
  state             = "available"

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }
}

data "aws_subnet" "subnet_b" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-west-2b"
  state             = "available"

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }
}

data "aws_security_group" "vpc_security_group" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "aws_key_pair" "student" {
  key_name = data.aws_caller_identity.current.account_id
}

