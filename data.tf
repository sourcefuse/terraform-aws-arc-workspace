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

// Bundle

data "aws_workspaces_bundle" "bundle" {
  owner = "AMAZON"
  name  = "Standard with Windows 10 (Server 2019 based)"
}
