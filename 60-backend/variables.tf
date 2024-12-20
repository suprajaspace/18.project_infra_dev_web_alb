variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "project"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "backend_tags" {
  default = {
    Component = "backend"
  }
}

variable "zone_name" {
  default = "vardhanglobal.online"
}

