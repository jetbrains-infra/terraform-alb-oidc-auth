resource "aws_security_group" "this" {
  name   = "alb-${var.project}-${var.env}"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all egress"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all http"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all https"
  }
  tags = var.common_tags
}

resource "aws_security_group" "backends" {
  name   = "alb-backends-${var.project}-${var.env}"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all egress"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
    description = "allow all inside sg"
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = [aws_security_group.this.id]
    description     = "allow all inside sg"
  }
  tags = var.common_tags
}
