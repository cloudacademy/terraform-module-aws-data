variable "random_string_length" {
  description = "Length of the random string"
  type        = number
  default     = 6
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}