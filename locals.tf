locals {
  private_subnet_cidr = [for s in data.aws_subnet.private : s.cidr_block]
  secret_name         = "${var.environment}/ad/password"
}
