#aws
variable "AWS_REGION" {
  type = string
}

variable "TFC_AWS_RUN_ROLE_ARN" {
  type = string
}

variable "TFC_AWS_PROVIDER_AUTH" {
  type = string
}

#Mine
variable "my_ip" {
  type    = string
  default = "100.1.47.199/32"
}
