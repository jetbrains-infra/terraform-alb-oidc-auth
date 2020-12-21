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

  tg = {
    name     = "alb-bi-ssrs"
    port     = "33555"
    protocol = "HTTP"

    healthcheck = {
      port     = "traffic-port"
      protocol = "HTTP"
      matcher  = "401"
      path     = "/reports/browse/"
    }
  }

  common_tags = {
    project = local.project
    env     = local.environment
    owner   = "john.doe@example.com"
  }
}

output "auth_data" {
  value = module.alb_with_auth
}
