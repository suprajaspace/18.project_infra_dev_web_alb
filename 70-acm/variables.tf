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


variable "zone_name" {
  default = "vardhanglobal.online"
}

variable "zone_id" {
  default = "Z0037057DV8PD1YP3QYK"
}