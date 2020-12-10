variable "project" {}
variable "env" {}
variable "common_tags" {}

variable "alb_subnets" {}
variable "vpc_id" {}
variable "dns_zone" {}

variable "auth_client_id" {}
variable "auth_client_secret" {}

# https://accounts.google.com/.well-known/openid-configuration
variable "auth_issuer" { default = "https://accounts.google.com" }
variable "auth_authorization_endpoint" { default = "https://accounts.google.com/o/oauth2/v2/auth" }
variable "auth_token_endpoint" { default = "https://oauth2.googleapis.com/token" }
variable "auth_user_info_endpoint" { default = "https://openidconnect.googleapis.com/v1/userinfo" }
variable "auth_scope" { default = "openid profile" }
