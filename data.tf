## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.namespace}-${var.environment}-vpc"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"

    values = [
      "${var.namespace}-${var.environment}-privatesubnet-private-${var.region}a",
      "${var.namespace}-${var.environment}-privatesubnet-private-${var.region}b"
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

data "aws_subnets" "public" {
  filter {
    name = "tag:Name"

    values = [
      "${var.namespace}-${var.environment}-publicsubnet-public-${var.region}a",
      "${var.namespace}-${var.environment}-publicsubnet-public-${var.region}b",
    ]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

##### Default workspace role

data "aws_iam_policy_document" "workspaces" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "workspaces_service_access" {
  name = "AmazonWorkSpacesServiceAccess"
}

data "aws_iam_policy" "workspaces_self_service_access" {
  name = "AmazonWorkSpacesSelfServiceAccess"
}

// default SG

data "aws_security_group" "default" {
  filter {
    name   = "tag:Name"
    values = ["arc-poc-vpc-default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

// Bundle 

data "aws_workspaces_bundle" "bundle" {
  owner = "AMAZON"
  name  = "Standard with Windows 10 (Server 2019 based)"
}
// secrets 

data "aws_secretsmanager_secret" "secrets" {
  name = local.secret_name
}

data "aws_secretsmanager_secret_version" "ad_password" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}
