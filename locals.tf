locals {
  private_subnet_cidr = [for s in data.aws_subnet.private : s.cidr_block]
  ssm_parameter_name = var.directory_type == "MicrosoftAD" ? "/workspace/ad/password" : ""
  ssm_ad_connector_parameter_name = var.directory_type == "MicrosoftAD" ? "/workspace/adConnector/password" : ""
}
