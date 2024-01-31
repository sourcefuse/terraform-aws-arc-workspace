################################################################################
## shared
################################################################################
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region"
}

variable "namespace" {
  type        = string
  description = "Namespace for the resources."
  default     = "woebot"
}

variable "environment" {
  type        = string
  description = "Name of the environment resources will belong to."
  default     = "dev"
}

variable "workspace_properties" {
  description = "Workspace properties configuration."
  type = object({
    compute_type_name                         = string
    user_volume_size_gib                      = number
    root_volume_size_gib                      = number
    running_mode                              = string
    running_mode_auto_stop_timeout_in_minutes = number
  })
  default = {
    compute_type_name                         = "POWERPRO"
    user_volume_size_gib                      = 100
    root_volume_size_gib                      = 175
    running_mode                              = "ALWAYS_ON"
    running_mode_auto_stop_timeout_in_minutes = 60
  }
}

variable "user_names" {
  description = "List of usernames to create workspaces for"
  type        = map(string)
  default     = {}
}

variable "ip_rules" {
  description = "List of IP rules"
  type = list(object({
    source      = string
    description = string
  }))
  default = [
    {
      source      = "150.24.14.0/24" // change it according to your requirement
      description = "NAT"
    },
    {
      source      = "125.191.14.85/32" // change it according to your requirement
      description = "NAT"
    },
  ]
}

variable "directory_type" {
  description = "Type of the directory service (MicrosoftAD or ADConnector)."
  type        = string
  default     = "MicrosoftAD" # Provide a default value
}

variable "directory_name" {
  description = "must be a fully qualified domain name and cannot end with a trailing period"
  type        = string
  default     = "poc.sourcefuse.com" # Provide a default value
}

variable "directory_size" {
  description = "The size of the directory (Small or Large are accepted values). Large by default."
  type        = string
  default     = "Small" # Provide a default value
}

variable "self_service_permissions" {
  description = "Self-service permissions configuration."
  type = object({
    change_compute_type  = bool
    increase_volume_size = bool
    rebuild_workspace    = bool
    restart_workspace    = bool
    switch_running_mode  = bool
  })
  default = {
    change_compute_type  = false
    increase_volume_size = false
    rebuild_workspace    = false
    restart_workspace    = true
    switch_running_mode  = false
  }
}

variable "workspace_access_properties" {
  description = "Workspace access properties configuration."
  type = object({
    device_type_android    = string
    device_type_chromeos   = string
    device_type_ios        = string
    device_type_linux      = string
    device_type_osx        = string
    device_type_web        = string
    device_type_windows    = string
    device_type_zeroclient = string
  })
  default = {
    device_type_android    = "ALLOW"
    device_type_chromeos   = "ALLOW"
    device_type_ios        = "ALLOW"
    device_type_linux      = "ALLOW"
    device_type_osx        = "ALLOW"
    device_type_web        = "DENY"
    device_type_windows    = "ALLOW"
    device_type_zeroclient = "ALLOW"
  }
}

variable "workspace_creation_properties" {
  description = "Workspace creation properties configuration."
  type = object({
    custom_security_group_id            = string
    default_ou                          = string
    enable_internet_access              = bool
    enable_maintenance_mode             = bool
    user_enabled_as_local_administrator = bool
  })
  default = {
    custom_security_group_id            = ""
    default_ou                          = ""
    enable_internet_access              = false
    enable_maintenance_mode             = true
    user_enabled_as_local_administrator = true
  }
}

variable "environment_name_conversion" {
  description = "Map environment name with Control Tower generated naming convention for VPC resource names."
  type        = map(string)
  default = {
    dev = "Non-Prod"
  }
}

variable "volume_encryption_key" {
  description = "encryption key"
  type        = string
  default     = ""
}
