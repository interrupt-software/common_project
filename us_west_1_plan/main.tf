terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    organization = "interrupt-software"

    workspaces {
      name = "pbmm_us_west_1_plan"
    }
  }
}

//--------------------------------------------------------------------
// Modules
module "randomer" {
  source  = "app.terraform.io/interrupt-software/randomer/provider"
  version = "1.0.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

output "random_pet" {
  description = "A random pet name for you"
  value       = module.randomer.pet
}

output "random_uuid" {
  description = "A random pet name for you"
  value       = module.randomer.uuid
}
