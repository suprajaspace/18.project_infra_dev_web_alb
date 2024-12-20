terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
  }

  backend "s3" {
    bucket         = "supra-remote-state"
    key            = "expense-app-alb-dev"
    region         = "us-east-1"
    dynamodb_table = "supra-locking"
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}