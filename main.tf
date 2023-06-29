resource "random_string" "random_string" {
  length  = var.random_string_length
  special = false
  upper   = false
  numeric = false
}

resource "random_uuid" "uuid" {}

resource "time_static" "time" {}