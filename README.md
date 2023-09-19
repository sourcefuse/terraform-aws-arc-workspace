# arc-terraform-workspace

## Overview

SourceFuse AWS Reference Architecture (ARC) Terraform module for managing Workspaces.

## Usage

To see a full example, check out the [main.tf](./example/main.tf) file in the example folder.  

```hcl
module "this" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-<module_name>"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_directory_service_directory.ADConnector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory) | resource |
| [aws_directory_service_directory.microsoftAD](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory) | resource |
| [aws_iam_role.workspaces_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.workspaces_default_self_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.workspaces_default_service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ssm_parameter.ad_connector_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ad_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_workspaces_directory.directory_ADConnector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_directory) | resource |
| [aws_workspaces_directory.directory_microsoftAD](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_directory) | resource |
| [aws_workspaces_workspace.workspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/workspaces_workspace) | resource |
| [random_password.ad_connector_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.ad_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.workspaces](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_workspaces_bundle.bundle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/workspaces_bundle) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bundle_id"></a> [bundle\_id](#input\_bundle\_id) | The ID of the bundle to use for the workspaces. | `string` | `null` | no |
| <a name="input_directory_connect_settings"></a> [directory\_connect\_settings](#input\_directory\_connect\_settings) | Connect settings for ADConnector. | <pre>object({<br>    customer_dns_ips  = list(string)<br>    customer_username = string<br>    subnet_ids        = list(string)<br>    vpc_id            = string<br>  })</pre> | <pre>{<br>  "customer_dns_ips": [],<br>  "customer_username": "",<br>  "subnet_ids": [],<br>  "vpc_id": ""<br>}</pre> | no |
| <a name="input_directory_name"></a> [directory\_name](#input\_directory\_name) | must be a fully qualified domain name and cannot end with a trailing period | `string` | `"poc.woebothealth.com"` | no |
| <a name="input_directory_size"></a> [directory\_size](#input\_directory\_size) | The size of the directory (Small or Large are accepted values). Large by default. | `string` | `"Small"` | no |
| <a name="input_directory_type"></a> [directory\_type](#input\_directory\_type) | Type of the directory service (MicrosoftAD or ADConnector). | `string` | `"MicrosoftAD"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_self_service_permissions"></a> [self\_service\_permissions](#input\_self\_service\_permissions) | Self-service permissions configuration. | <pre>object({<br>    change_compute_type  = bool<br>    increase_volume_size = bool<br>    rebuild_workspace    = bool<br>    restart_workspace    = bool<br>    switch_running_mode  = bool<br>  })</pre> | <pre>{<br>  "change_compute_type": false,<br>  "increase_volume_size": false,<br>  "rebuild_workspace": false,<br>  "restart_workspace": true,<br>  "switch_running_mode": false<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | private subnet\_ids | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to add to your resources | `map(string)` | n/a | yes |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | List of usernames to create workspaces for | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | default vpc | `string` | n/a | yes |
| <a name="input_workspace_access_properties"></a> [workspace\_access\_properties](#input\_workspace\_access\_properties) | Workspace access properties configuration. | <pre>object({<br>    device_type_android    = string<br>    device_type_chromeos   = string<br>    device_type_ios        = string<br>    device_type_linux      = string<br>    device_type_osx        = string<br>    device_type_web        = string<br>    device_type_windows    = string<br>    device_type_zeroclient = string<br>  })</pre> | <pre>{<br>  "device_type_android": "ALLOW",<br>  "device_type_chromeos": "ALLOW",<br>  "device_type_ios": "ALLOW",<br>  "device_type_linux": "ALLOW",<br>  "device_type_osx": "ALLOW",<br>  "device_type_web": "DENY",<br>  "device_type_windows": "ALLOW",<br>  "device_type_zeroclient": "ALLOW"<br>}</pre> | no |
| <a name="input_workspace_creation_properties"></a> [workspace\_creation\_properties](#input\_workspace\_creation\_properties) | Workspace creation properties configuration. | <pre>object({<br>    custom_security_group_id            = string<br>    default_ou                          = string<br>    enable_internet_access              = bool<br>    enable_maintenance_mode             = bool<br>    user_enabled_as_local_administrator = bool<br>  })</pre> | <pre>{<br>  "custom_security_group_id": "",<br>  "default_ou": "",<br>  "enable_internet_access": false,<br>  "enable_maintenance_mode": true,<br>  "user_enabled_as_local_administrator": true<br>}</pre> | no |
| <a name="input_workspace_properties"></a> [workspace\_properties](#input\_workspace\_properties) | Workspace properties configuration. | <pre>object({<br>    compute_type_name                         = string<br>    user_volume_size_gib                      = number<br>    root_volume_size_gib                      = number<br>    running_mode                              = string<br>    running_mode_auto_stop_timeout_in_minutes = number<br>  })</pre> | <pre>{<br>  "compute_type_name": "VALUE",<br>  "root_volume_size_gib": 80,<br>  "running_mode": "ALWAYS_ON",<br>  "running_mode_auto_stop_timeout_in_minutes": 60,<br>  "user_volume_size_gib": 10<br>}</pre> | no |
| <a name="input_workspaces_self_service_access_arn"></a> [workspaces\_self\_service\_access\_arn](#input\_workspaces\_self\_service\_access\_arn) | workspaces self service access from aws | `string` | n/a | yes |
| <a name="input_workspaces_service_access_arn"></a> [workspaces\_service\_access\_arn](#input\_workspaces\_service\_access\_arn) | workspaces service access from aws | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_bundle_id"></a> [workspace\_bundle\_id](#output\_workspace\_bundle\_id) | The ID of the AWS Workspaces bundle. |
| <a name="output_workspace_directory_id"></a> [workspace\_directory\_id](#output\_workspace\_directory\_id) | The ID of the AWS Workspaces directory. |
| <a name="output_workspace_properties"></a> [workspace\_properties](#output\_workspace\_properties) | The properties of the AWS Workspaces. |
| <a name="output_workspace_root_volume_encryption_enabled"></a> [workspace\_root\_volume\_encryption\_enabled](#output\_workspace\_root\_volume\_encryption\_enabled) | Whether root volume encryption is enabled for the AWS Workspaces. |
| <a name="output_workspace_user_name"></a> [workspace\_user\_name](#output\_workspace\_user\_name) | The username of the AWS Workspaces user. |
| <a name="output_workspace_user_volume_encryption_enabled"></a> [workspace\_user\_volume\_encryption\_enabled](#output\_workspace\_user\_volume\_encryption\_enabled) | Whether user volume encryption is enabled for the AWS Workspaces. |
| <a name="output_workspace_volume_encryption_key"></a> [workspace\_volume\_encryption\_key](#output\_workspace\_volume\_encryption\_key) | The encryption key used for AWS Workspaces volumes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Versioning  
This project uses a `.version` file at the root of the repo which the pipeline reads from and does a git tag.  

When you intend to commit to `main`, you will need to increment this version. Once the project is merged,
the pipeline will kick off and tag the latest git commit.  

## Development

### Prerequisites

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install#installing-terraform)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/#install)
- [golang](https://golang.org/doc/install#install)
- [golint](https://github.com/golang/lint#installation)

### Configurations

- Configure pre-commit hooks
  ```sh
  pre-commit install
  ```

### Tests
- Tests are available in `test` directory
- Configure the dependencies
  ```sh
  cd test/
  go mod init github.com/sourcefuse/terraform-aws-refarch-<module_name>
  go get github.com/gruntwork-io/terratest/modules/terraform
  ```
- Now execute the test  
  ```sh
  go test -timeout  30m
  ```

## Authors

This project is authored by:
- SourceFuse
