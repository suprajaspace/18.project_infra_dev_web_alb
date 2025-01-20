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

variable "web_alb_tags" {
  default = {
    Component = "web-alb"
  }
}

variable "zone_name" {
  default = "vardhanglobal.online"
}