provider "aws" {
  region = "eu-north-1"
}

locals {
  project     = "example"
  environment = "dev"
}

module "alb_with_auth" {
  source = "../"

  project     = local.project
  env         = local.environment

  dns_zone = "example.com"
  alb_subnets = [
    "subnet-01234567890abcd",
    "subnet-01234567890dcba",
  ]
  vpc_id = "vpc-12345678900"

  auth_client_id     = "XXX"
  auth_client_secret = "YYY"

  common_tags = {
    project = local.project
    env     = local.environment
    owner   = "john.doe@example.com"
  }
}

output "auth_data" {
  value = module.alb_with_auth
}
