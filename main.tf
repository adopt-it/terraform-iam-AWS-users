data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
}


data "aws_iam_policy_document" "user_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

  }
}

#Create a test role to be assumed by further users and groups
resource "aws_iam_role" "test_role" {
  name               = "${var.role_name}-role"
  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}

#Attach default policy to defined role
resource "aws_iam_role_policy_attachment" "test_role_readonly_access" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

#Call module to launch the IAM users/groups & roles
module "iam_create_users" {
       source = "./module_groups_iam"
        allowed_roles = [
         	aws_iam_role.test_role.arn,
        ]
	users = var.users
}