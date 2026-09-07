resource "aws_security_group" "sg" {
  name        = "sg"
  description = "this is a sg"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "this is ingress for  first-tf-instance"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
