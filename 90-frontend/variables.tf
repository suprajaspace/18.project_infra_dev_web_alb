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

variable "frontend_tags" {
  default = {
    Component = "frontend"
  }
}

variable "zone_name" {
  default = "vardhanglobal.online"
}

