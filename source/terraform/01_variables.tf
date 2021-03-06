variable "project" {}

variable "stage" {}

variable "rentation_in_days" {
  default = "7"
}

variable "obcon_module_bucket" {
  default = "obcon-aws-modules"
}

variable "obcon_module_version" {
  default = "1.0"
}

variable "obcon_module_name" {
  default = "aws-cloudwatch-log-cleaner"
}
