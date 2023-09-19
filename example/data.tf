## network
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["HIS-WL-${var.environment_name_conversion[var.environment]}-Main"]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "tag:Name"

    values = [
      "HIS-WL-${var.environment_name_conversion[var.environment]}-App-A",
      "HIS-WL-${var.environment_name_conversion[var.environment]}-App-B"
    ]
  }
}

data "aws_iam_policy" "workspaces_service_access" {
  name = "AmazonWorkSpacesServiceAccess"
}

data "aws_iam_policy" "workspaces_self_service_access" {
  name = "AmazonWorkSpacesSelfServiceAccess"
}



