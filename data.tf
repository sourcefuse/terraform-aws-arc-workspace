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

// default SG

# data "aws_security_group" "default" {
#   filter {
#     name   = "tag:Name"
#     values = ["arc-poc-vpc-default"]
#   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }
# }

// Bundle

data "aws_workspaces_bundle" "bundle" {
  owner = "AMAZON"
  name  = "Standard with Windows 10 (Server 2019 based)"
}
