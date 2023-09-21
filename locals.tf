locals {
  ssm_parameter_name              = var.directory_type == "MicrosoftAD" ? coalesce(var.ssm_parameter_name, "/workspace/ad/password") : ""
  ssm_ad_connector_parameter_name = var.directory_type == "ADConnector" ? coalesce(var.ssm_ad_connector_parameter_name, "/workspace/adConnector/password") : ""

}
