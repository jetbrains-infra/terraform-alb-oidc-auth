output "auth_redirect_uri" {
  value = "\nhttps://${aws_route53_record.this.fqdn}/oauth2/idpresponse\nhttps://${aws_alb.this.dns_name}/oauth2/idpresponse\n"
}

output "alb_security_group" {
  value = aws_security_group.this.id
}

output "backends_security_group" {
  value = aws_security_group.backends.id
}

output "alb_target_group_id" {
  value = aws_alb_target_group.this.id
}

output "alb_target_group_name" {
  value = aws_alb_target_group.this.name
}

output "alb_dns_name" {
  value = aws_alb.this.dns_name
}

output "alb_dns_zone_id" {
  value = aws_alb.this.zone_id
}
