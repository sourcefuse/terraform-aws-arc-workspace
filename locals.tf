locals {
  ssm_parameter_name              = var.directory_type == "MicrosoftAD" ? "/workspace/ad/password" : ""
  ssm_ad_connector_parameter_name = var.directory_type == "MicrosoftAD" ? "/workspace/adConnector/password" : ""
}
