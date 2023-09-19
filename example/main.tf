################################################################################
## defaults
################################################################################
terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "tags" {
  source = "git::https://github.com/sourcefuse/terraform-aws-refarch-tags.git?ref=1.2.1"

  environment = var.environment
  project     = var.namespace

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/workspaces"
  }
}

module "workspaces" {
  source = "../" # Replace with the relative path to your module folder

  region                             = var.region
  vpc_id                             = data.aws_vpc.vpc.id
  subnet_ids                         = data.aws_subnets.private.ids
  directory_type                     = var.directory_type
  directory_name                     = var.directory_name
  directory_size                     = var.directory_size
  self_service_permissions           = var.self_service_permissions
  workspace_access_properties        = var.workspace_access_properties
  workspace_creation_properties      = var.workspace_creation_properties
  workspaces_service_access_arn      = data.aws_iam_policy.workspaces_service_access.arn
  workspaces_self_service_access_arn = data.aws_iam_policy.workspaces_self_service_access.arn
  user_names = {
    "mayank.sharma" = null
  }
  workspace_properties = var.workspace_properties
  tags                 = module.tags.tags
}
