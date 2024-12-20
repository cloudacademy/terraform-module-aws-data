data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [data.aws_region.current.id]
  }
}


data "aws_vpc" "default" {
  default = true
  state   = "available"
}

data "aws_route_table" "default" {
  route_table_id = data.aws_vpc.default.main_route_table_id
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "subnet_a" {
  vpc_id = data.aws_vpc.default.id
  state  = "available"

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }

  filter {
    name   = "tag:Name"
    values = ["subnet-a"]
  }
}

data "aws_network_acls" "subnet_a" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "association.subnet-id"
    values = [data.aws_subnet.subnet_a.id]
  }
}

data "aws_subnet" "subnet_b" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }

  filter {
    name   = "tag:Name"
    values = ["subnet-b"]
  }
}

data "aws_network_acls" "subnet_b" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "association.subnet-id"
    values = [data.aws_subnet.subnet_b.id]
  }
}

data "aws_security_group" "vpc_security_group" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
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

