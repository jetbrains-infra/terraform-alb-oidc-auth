resource "aws_alb" "this" {
  name     = "alb-${var.project}-${var.env}"
  internal = false

  security_groups = [aws_security_group.this.id]
  subnets         = var.alb_subnets

  tags            = var.common_tags
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type = "authenticate-oidc"

    authenticate_oidc {
      authorization_endpoint = var.auth_authorization_endpoint
      client_id              = var.auth_client_id
      client_secret          = var.auth_client_secret
      issuer                 = var.auth_issuer
      token_endpoint         = var.auth_token_endpoint
      user_info_endpoint     = var.auth_user_info_endpoint

      scope = var.auth_scope

      on_unauthenticated_request = "authenticate"
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }

  depends_on = [aws_acm_certificate.this]
}

resource "aws_alb_target_group" "this" {
  name = "alb-${var.project}-${var.env}"

  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }

  tags = var.common_tags
}
