#aws
variable "AWS_REGION" {
  type = string
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

#lacework
variable "lacework_account_name" {
  type = string
}

variable "proxy_scanner_token" {
  type = string
}

variable "lw_eks_agent_token" {
  type = string
}

variable "registry_username" {
  type = string
}

variable "registry_password" {
  type = string
}

#Mine
variable "my_ip" {
  type    = string
  default = "100.1.47.199/32"
}
