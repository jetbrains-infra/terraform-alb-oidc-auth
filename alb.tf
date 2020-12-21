resource "aws_alb" "this" {
  name     = "alb-${var.project}-${var.env}"
  internal = false

  security_groups            = [aws_security_group.this.id]
  subnets                    = var.alb_subnets
  enable_deletion_protection = true
  idle_timeout               = 3600

  access_logs {
    bucket  = "jetbrains-bi-data"
    prefix  = "alb-bi-prod-logs"
    enabled = true
  }

  tags = var.common_tags
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
  name     = var.tg.name
  port     = var.tg.port
  protocol = var.tg.protocol

  vpc_id = var.vpc_id
  deregistration_delay = 120

  health_check {
    port                = var.tg.healthcheck.port
    protocol            = var.tg.healthcheck.protocol
    matcher             = var.tg.healthcheck.matcher
    path                = var.tg.healthcheck.path
    interval            = 60
    unhealthy_threshold = 2
    timeout             = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }

  tags = var.common_tags
}
