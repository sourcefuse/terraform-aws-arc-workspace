################################################################################
## defaults
################################################################################
terraform {
  required_version = ">= 1.5, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "workspace" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

////////// IP GROUPS

resource "aws_workspaces_ip_group" "nat" {
  name        = var.ip_group_name
  description = var.ip_group_description

  dynamic "rules" {
    for_each = var.ip_rules
    content {
      source      = rules.value.source
      description = rules.value.description
    }
  }
}

resource "aws_workspaces_directory" "directory_microsoftAD" {
  count = var.directory_type == "MicrosoftAD" ? 1 : 0

  directory_id = aws_directory_service_directory.microsoftAD[0].id
  subnet_ids   = var.subnet_ids

  tags = var.tags

  self_service_permissions {
    change_compute_type  = var.self_service_permissions.change_compute_type
    increase_volume_size = var.self_service_permissions.increase_volume_size
    rebuild_workspace    = var.self_service_permissions.rebuild_workspace
    restart_workspace    = var.self_service_permissions.restart_workspace
    switch_running_mode  = var.self_service_permissions.switch_running_mode
  }

  workspace_access_properties {
    device_type_android    = var.workspace_access_properties.device_type_android
    device_type_chromeos   = var.workspace_access_properties.device_type_chromeos
    device_type_ios        = var.workspace_access_properties.device_type_ios
    device_type_linux      = var.workspace_access_properties.device_type_linux
    device_type_osx        = var.workspace_access_properties.device_type_osx
    device_type_web        = var.workspace_access_properties.device_type_web
    device_type_windows    = var.workspace_access_properties.device_type_windows
    device_type_zeroclient = var.workspace_access_properties.device_type_zeroclient
  }

  workspace_creation_properties {
    custom_security_group_id            = aws_security_group.workspace.id
    default_ou                          = var.workspace_creation_properties.default_ou
    enable_internet_access              = var.workspace_creation_properties.enable_internet_access
    enable_maintenance_mode             = var.workspace_creation_properties.enable_maintenance_mode
    user_enabled_as_local_administrator = var.workspace_creation_properties.user_enabled_as_local_administrator
  }

  ip_group_ids = [
    aws_workspaces_ip_group.nat.id
  ]

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access
  ]
}

resource "aws_workspaces_directory" "directory_ADConnector" {
  count = var.directory_type == "ADConnector" ? 1 : 0

  directory_id = aws_directory_service_directory.ADConnector[0].id
  subnet_ids   = var.subnet_ids

  tags = var.tags

  self_service_permissions {
    change_compute_type  = var.self_service_permissions.change_compute_type
    increase_volume_size = var.self_service_permissions.increase_volume_size
    rebuild_workspace    = var.self_service_permissions.rebuild_workspace
    restart_workspace    = var.self_service_permissions.restart_workspace
    switch_running_mode  = var.self_service_permissions.switch_running_mode
  }

  workspace_access_properties {
    device_type_android    = var.workspace_access_properties.device_type_android
    device_type_chromeos   = var.workspace_access_properties.device_type_chromeos
    device_type_ios        = var.workspace_access_properties.device_type_ios
    device_type_linux      = var.workspace_access_properties.device_type_linux
    device_type_osx        = var.workspace_access_properties.device_type_osx
    device_type_web        = var.workspace_access_properties.device_type_web
    device_type_windows    = var.workspace_access_properties.device_type_windows
    device_type_zeroclient = var.workspace_access_properties.device_type_zeroclient
  }

  workspace_creation_properties {
    custom_security_group_id            = aws_security_group.workspace.id
    default_ou                          = var.workspace_creation_properties.default_ou
    enable_internet_access              = var.workspace_creation_properties.enable_internet_access
    enable_maintenance_mode             = var.workspace_creation_properties.enable_maintenance_mode
    user_enabled_as_local_administrator = var.workspace_creation_properties.user_enabled_as_local_administrator
  }

  ip_group_ids = [
    aws_workspaces_ip_group.nat.id
  ]

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access
  ]
}

resource "random_password" "ad_password" {
  length           = 20
  special          = true
  override_special = "!@#$%^&*()"
}

resource "aws_ssm_parameter" "ad_password" {
  count = var.directory_type == "MicrosoftAD" ? 1 : 0
  name  = local.ssm_parameter_name # Replace with your desired SSM parameter name
  type  = "SecureString"
  value = random_password.ad_password.result
}

resource "aws_directory_service_directory" "microsoftAD" {
  count    = var.directory_type == "MicrosoftAD" ? 1 : 0
  name     = var.directory_name
  password = random_password.ad_password.result
  size     = var.directory_size
  edition  = "Standard"
  type     = var.directory_type

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }
}

resource "random_password" "ad_connector_password" {
  length           = 20
  special          = true
  override_special = "!@#$%^&*()"
}

resource "aws_ssm_parameter" "ad_connector_password" {
  count = var.directory_type == "ADConnector" ? 1 : 0
  name  = local.ssm_ad_connector_parameter_name # Replace with your desired SSM parameter name
  type  = "SecureString"
  value = random_password.ad_connector_password.result
}

resource "aws_directory_service_directory" "ADConnector" {
  count    = var.directory_type == "ADConnector" ? 1 : 0
  name     = var.directory_name
  password = random_password.ad_connector_password.result
  size     = var.directory_size
  type     = var.directory_type

  connect_settings {
    customer_dns_ips  = var.customer_dns_ips
    customer_username = var.customer_username
    subnet_ids        = var.subnet_ids
    vpc_id            = var.vpc_id
  }
}


#####################################################################
########### Iam role and Policy Attachment ##########################

resource "aws_iam_role" "workspaces_default" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.workspaces.json
}

resource "aws_iam_role_policy_attachment" "workspaces_default_service_access" {
  role       = aws_iam_role.workspaces_default.name
  policy_arn = var.workspaces_service_access_arn
}

resource "aws_iam_role_policy_attachment" "workspaces_default_self_service_access" {
  role       = aws_iam_role.workspaces_default.name
  policy_arn = var.workspaces_self_service_access_arn
}

#####################################################################
########### workspace ##########################

resource "aws_workspaces_workspace" "workspace" {
  for_each     = var.user_names
  directory_id = var.directory_type == "MicrosoftAD" ? aws_directory_service_directory.microsoftAD[0].id : aws_directory_service_directory.ADConnector[0].id
  bundle_id    = var.bundle_id != null ? var.bundle_id : data.aws_workspaces_bundle.bundle.id
  user_name    = each.key

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = var.volume_encryption_key

  workspace_properties {
    compute_type_name                         = var.workspace_properties.compute_type_name
    user_volume_size_gib                      = var.workspace_properties.user_volume_size_gib
    root_volume_size_gib                      = var.workspace_properties.root_volume_size_gib
    running_mode                              = var.workspace_properties.running_mode
    running_mode_auto_stop_timeout_in_minutes = var.workspace_properties.running_mode_auto_stop_timeout_in_minutes
  }


  tags = var.tags
  depends_on = [
    aws_directory_service_directory.microsoftAD,
    aws_workspaces_directory.directory_microsoftAD
  ]
}
