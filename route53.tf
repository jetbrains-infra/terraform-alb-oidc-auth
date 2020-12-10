data aws_route53_zone this {
  name = var.dns_zone
}

resource "aws_route53_record" "this" {
  name = "alb-${var.project}-${var.env}"
  type = "A"
  zone_id = data.aws_route53_zone.this.zone_id
  alias {
    evaluate_target_health = false
    name = aws_alb.this.dns_name
    zone_id = aws_alb.this.zone_id
  }
}
