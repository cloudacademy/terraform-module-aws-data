output "lab" {
  value = {
    uuid          = random_uuid.uuid.result
    unixtime      = time_static.time.unix
    rfc3339_time  = time_static.time.rfc3339
    random_string = random_string.random_string.id
  }
}

output "aws" {
  value = {
    account_id         = data.aws_caller_identity.current.account_id
    partition          = data.aws_partition.current.id
    region             = data.aws_region.current.name
    availability_zones = data.aws_availability_zones.available.names
    key_pair_name      = data.aws_key_pair.student.key_name
  }
}

output "default_vpc" {
  value = {
    id         = data.aws_vpc.default.id
    cidr_block = data.aws_vpc.default.cidr_block
    internet_gateway = {
      id = data.aws_internet_gateway.default.id
    }
    security_group = {
      id = data.aws_security_group.vpc_security_group.id
    }
    subnets = {
      a = {
        id                = data.aws_subnet.subnet_a.id
        cidr_block        = data.aws_subnet.subnet_a.cidr_block
        availability_zone = data.aws_subnet.subnet_a.availability_zone
        nacl = {
          id = data.aws_network_acls.subnet_a.ids[0]
        }
      }
      b = {
        id                = data.aws_subnet.subnet_b.id
        cidr_block        = data.aws_subnet.subnet_b.cidr_block
        availability_zone = data.aws_subnet.subnet_b.availability_zone
        nacl = {
          id = data.aws_network_acls.subnet_b.ids[0]
        }
      }
    }
  }
}

output "amis" {
  value = {
    amazon_linux_2 = {
      id = nonsensitive(data.aws_ssm_parameter.amazon_linux_2.value)
    }
    amazon_linux_2023 = {
      id = nonsensitive(data.aws_ssm_parameter.amazon_linux_2023.value)
    }
  }
}
