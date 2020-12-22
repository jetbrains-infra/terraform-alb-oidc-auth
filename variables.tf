variable "project" {}
variable "env" {}
variable "common_tags" {}

variable "alb_subnets" {}
variable "vpc_id" {}
variable "dns_zone" {}
variable "dns_name" {}

variable "auth_client_id" {}
variable "auth_client_secret" {}

# https://accounts.google.com/.well-known/openid-configuration
variable "auth_issuer" { default = "https://accounts.google.com" }
variable "auth_authorization_endpoint" { default = "https://accounts.google.com/o/oauth2/v2/auth" }
variable "auth_token_endpoint" { default = "https://oauth2.googleapis.com/token" }
variable "auth_user_info_endpoint" { default = "https://openidconnect.googleapis.com/v1/userinfo" }
variable "auth_scope" { default = "openid profile" }

variable tg {}
variable cert_validation { default = true }

variable alb_access_logs_enabled { default = true }
variable alb_access_logs_prefix { default = "" }
variable alb_access_logs_bucket { default = "" }
variable alb_delete_protection { default = true }
variable alb_idle_timeout { default = 300 }