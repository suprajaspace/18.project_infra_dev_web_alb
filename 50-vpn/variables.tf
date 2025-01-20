variable "project_name" {
  default = "target"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "target"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "vpn_tags" {
  default = {
    Component = "vpn"
  }
}
