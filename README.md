# AWS Data Terraform Module 

A terraform module for use in lab provisioning blocks that encapsulates and exposes interesting data about the AWS cloud environment.

See the [outputs.tf](outputs.tf) file for exposed data available for use.

## Example Usage

```tf
# Define the module
module aws_data {
    source = "github.com/cloudacademy/terraform-module-aws-data"

    random_string_length = 8
}

# Use the module
resource "aws_security_group" "example" {
  name        = "example"
  description = "Example"
  vpc_id      = module.aws_data.default_vpc_id
}

data "aws_s3_bucket" "example" {
  bucket = "lab-example-${module.aws_data.random_string}-${module.aws_data.unixtime}"
}
```