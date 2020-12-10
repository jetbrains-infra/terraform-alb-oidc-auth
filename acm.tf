resource "aws_acm_certificate" "this" {
  domain_name       = aws_route53_record.this.fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.common_tags
}

resource "aws_route53_record" "cert_validation" {
  name            = aws_acm_certificate.this.domain_validation_options.*.resource_record_name[0]
  records         = [aws_acm_certificate.this.domain_validation_options.*.resource_record_value[0]]
  type            = aws_acm_certificate.this.domain_validation_options.*.resource_record_type[0]
  zone_id         = data.aws_route53_zone.this.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}