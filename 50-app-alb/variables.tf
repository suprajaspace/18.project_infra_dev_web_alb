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

variable "app_alb_tags" {
  default = {
    Component = "app-alb"
  }
}



variable "zone_name" {
  default = "vardhanglobal.online"
}