# terraform-aws-module-template example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.com/sourcefuse/terraform-aws-refarch-tags.git | 1.2.1 |
| <a name="module_workspaces"></a> [workspaces](#module\_workspaces) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.workspaces_self_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.workspaces_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_directory_name"></a> [directory\_name](#input\_directory\_name) | must be a fully qualified domain name and cannot end with a trailing period | `string` | `"poc.woebothealth.com"` | no |
| <a name="input_directory_size"></a> [directory\_size](#input\_directory\_size) | The size of the directory (Small or Large are accepted values). Large by default. | `string` | `"Small"` | no |
| <a name="input_directory_type"></a> [directory\_type](#input\_directory\_type) | Type of the directory service (MicrosoftAD or ADConnector). | `string` | `"MicrosoftAD"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment resources will belong to. | `string` | `"dev"` | no |
| <a name="input_environment_name_conversion"></a> [environment\_name\_conversion](#input\_environment\_name\_conversion) | Map environment name with Control Tower generated naming convention for VPC resource names. | `map(string)` | <pre>{<br>  "dev": "Non-Prod"<br>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the resources. | `string` | `"woebot"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_self_service_permissions"></a> [self\_service\_permissions](#input\_self\_service\_permissions) | Self-service permissions configuration. | <pre>object({<br>    change_compute_type  = bool<br>    increase_volume_size = bool<br>    rebuild_workspace    = bool<br>    restart_workspace    = bool<br>    switch_running_mode  = bool<br>  })</pre> | <pre>{<br>  "change_compute_type": false,<br>  "increase_volume_size": false,<br>  "rebuild_workspace": false,<br>  "restart_workspace": true,<br>  "switch_running_mode": false<br>}</pre> | no |
| <a name="input_workspace_access_properties"></a> [workspace\_access\_properties](#input\_workspace\_access\_properties) | Workspace access properties configuration. | <pre>object({<br>    device_type_android    = string<br>    device_type_chromeos   = string<br>    device_type_ios        = string<br>    device_type_linux      = string<br>    device_type_osx        = string<br>    device_type_web        = string<br>    device_type_windows    = string<br>    device_type_zeroclient = string<br>  })</pre> | <pre>{<br>  "device_type_android": "ALLOW",<br>  "device_type_chromeos": "ALLOW",<br>  "device_type_ios": "ALLOW",<br>  "device_type_linux": "ALLOW",<br>  "device_type_osx": "ALLOW",<br>  "device_type_web": "DENY",<br>  "device_type_windows": "ALLOW",<br>  "device_type_zeroclient": "ALLOW"<br>}</pre> | no |
| <a name="input_workspace_creation_properties"></a> [workspace\_creation\_properties](#input\_workspace\_creation\_properties) | Workspace creation properties configuration. | <pre>object({<br>    custom_security_group_id            = string<br>    default_ou                          = string<br>    enable_internet_access              = bool<br>    enable_maintenance_mode             = bool<br>    user_enabled_as_local_administrator = bool<br>  })</pre> | <pre>{<br>  "custom_security_group_id": "",<br>  "default_ou": "",<br>  "enable_internet_access": false,<br>  "enable_maintenance_mode": true,<br>  "user_enabled_as_local_administrator": true<br>}</pre> | no |
| <a name="input_workspace_properties"></a> [workspace\_properties](#input\_workspace\_properties) | Workspace properties configuration. | <pre>object({<br>    compute_type_name                         = string<br>    user_volume_size_gib                      = number<br>    root_volume_size_gib                      = number<br>    running_mode                              = string<br>    running_mode_auto_stop_timeout_in_minutes = number<br>  })</pre> | <pre>{<br>  "compute_type_name": "POWERPRO",<br>  "root_volume_size_gib": 175,<br>  "running_mode": "ALWAYS_ON",<br>  "running_mode_auto_stop_timeout_in_minutes": 60,<br>  "user_volume_size_gib": 100<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
