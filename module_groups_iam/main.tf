locals {
# Flatten and get unique group names to process further
  group_memberships = distinct((flatten([
    for username, value in var.users : [
      for group_membership in value["group_memberships"] : {
        group_membership = group_membership
      }
    ]
  ])))
}

#Create users based on the Users data set we have defined
resource "aws_iam_user" "this" {
  for_each = var.users

  name                 = each.key
  path                 = each.value["path"]
  force_destroy        = each.value["force_destroy"]
}

#Wait until users are created and add groups as appropiate
resource "aws_iam_user_group_membership" "this" {
  for_each = var.users

  user   = each.key
  groups = each.value["group_memberships"]

  depends_on = [aws_iam_user.this]
}


#
# IAM policy to permit the user group to assume the role given to the module
#

data "aws_iam_policy_document" "assume_role_policy_doc" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = var.allowed_roles
  }
}

#Add Group object 
resource "aws_iam_group" "user_group" {
 count = length(local.group_memberships)
 name=local.group_memberships[count.index].group_membership
 
}

#Create roles for each group (users should be able to assume them);
resource "aws_iam_policy" "assume_role_policy" {

  count = length(aws_iam_group.user_group)
  name        = "assume-role-${aws_iam_group.user_group[count.index].name}"
  path        = "/"
  description = "Allows the role ${aws_iam_group.user_group[count.index].name} to be assumed."
  policy      = data.aws_iam_policy_document.assume_role_policy_doc.json
}

resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment" {
  count = length(aws_iam_group.user_group)
  group      = aws_iam_group.user_group[count.index].name
  policy_arn = aws_iam_policy.assume_role_policy[count.index].arn
}





