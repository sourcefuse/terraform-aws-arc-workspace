output "workspace_directory_id" {
  description = "The ID of the AWS Workspaces directory."
  value       = var.directory_type == "MicrosoftAD" ? aws_workspaces_directory.directory_microsoftAD[0].directory_id : aws_workspaces_directory.directory_ADConnector[0].directory_id
}

output "workspace_bundle_id" {
  description = "The ID of the AWS Workspaces bundle."
  value       = data.aws_workspaces_bundle.bundle.id
}

output "workspace_user_name" {
  description = "The username of the AWS Workspaces user."
  value       = var.user_name
}

output "workspace_root_volume_encryption_enabled" {
  description = "Whether root volume encryption is enabled for the AWS Workspaces."
  value       = true
}

output "workspace_user_volume_encryption_enabled" {
  description = "Whether user volume encryption is enabled for the AWS Workspaces."
  value       = true
}

output "workspace_volume_encryption_key" {
  description = "The encryption key used for AWS Workspaces volumes."
  value       = "alias/aws/workspaces"
}

output "workspace_properties" {
  description = "The properties of the AWS Workspaces."
  value = {
    compute_type_name                         = var.workspace_properties.compute_type_name
    user_volume_size_gib                      = var.workspace_properties.user_volume_size_gib
    root_volume_size_gib                      = var.workspace_properties.root_volume_size_gib
    running_mode                              = var.workspace_properties.running_mode
    running_mode_auto_stop_timeout_in_minutes = var.workspace_properties.running_mode_auto_stop_timeout_in_minutes
  }
}

output "workspace_tags" {
  description = "The tags associated with AWS Workspaces."
  value       = module.tags.tags
}
