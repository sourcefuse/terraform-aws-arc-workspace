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

module "ad-connector-workspace" {
  source                             = "sourcefuse/workspace/aws"
  version                            = "1.0.7"
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
  user_names                         = var.user_names // first run terraform apply and then create custom user names in workspace manually and specify here that username and re-run tf apply so that workspace with custom-username gets created . By default you can specify Administrators , Admins here which are default in directory and that will create workspace
  workspace_properties               = var.workspace_properties
  customer_dns_ips                   = var.customer_dns_ips
  customer_username                  = var.customer_username
  volume_encryption_key              = var.volume_encryption_key /// Add the key arn of kms or CMK (make sure if you change the key after creating workspace from terraform then it will destroy and re-create the workspace.)
  ip_rules                           = var.ip_rules              // change it according to your requirement
  tags                               = module.tags.tags
}
