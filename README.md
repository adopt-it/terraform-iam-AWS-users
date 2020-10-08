# AWS Identity and Access Management (IAM) with Terraform (a sample use case)

## Background

Terraform modules & scripts to create user, groups & roles within AWS IAM. 

Moreover, let us say we have two groups of users. The first group - "Developers", with users: Eugene,
Milo, Abigail, Aidan. The second group - "Ops", with users: Santiago, Felix, Morgan.

Furthermore, we want to achive the following tasks:
1. Writing Terraform code which will:
- Create users and groups
- Assign users to the groups
- Create roles for each group (users should be able to assume them); not necessary to
assign any policies to the roles.

## Prerequisites 📋


First, some things you will need:

```
Terraform at least v0.13.4 
You should have a profile configured in your ~/.aws/credentials file
An Amazon AWS account (if you want to test only)
```

For reference, the terraform scripts were run by using MacOS Mojave

## Variables 🔧
In order to execute properly, we have to first define some variables within [variables.tf](variables.tf) on the root directory:
| Template | Description |
| --- | --- | 
| region | Amazon AWS region to use for running terraform scripts. |
| role_name | Sample role to be created for the different users to be able to assume automatically. |
| users | A hash map of users and their details to be added. Also, the keys are user names, whereas the inner keys are defined in the terraform documentation. |

## How to use 📦
1. Make sure to configure your amazon credentials in case you want to test
2. after cloning the repository, at the root level, execute:
``` 
terraform init 
```
to install any dependencies and modules required.
3. Edit the file [variables.tf](variables.tf) with the required values for the users.
4. Make sure to proceed first with a dry-run approach to list down the activities and resources from terraform:
```
terraform plan
```
which will give an output like the following one:
```
➜  terraform-iam-AWS-users git:(main) ✗ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_caller_identity.current: Refreshing state...
data.aws_iam_policy_document.user_assume_role_policy: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # aws_iam_role.test_role will be created
  + resource "aws_iam_role" "test_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "yyyyyyyyy"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "yyyy-yy-mmm"
            }
        )
    }

  # aws_iam_role_policy_attachment.test_role_readonly_access will be created
  + resource "aws_iam_role_policy_attachment" "test_role_readonly_access" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
      + role       = "InfraUsers-role"
    }

  # module.iam_create_users.data.aws_iam_policy_document.assume_role_policy_doc will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "assume_role_policy_doc"  {
      + id   = (known after apply)
      + json = (known after apply)

      + statement {
          + actions   = [
              + "sts:AssumeRole",
            ]
          + resources = [
              + (known after apply),
            ]
        }
    }

  # module.iam_create_users.aws_iam_group.user_group[0] will be created
  + resource "aws_iam_group" "user_group" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "Developers"
      + path      = "/"
      + unique_id = (known after apply)
    }

  # module.iam_create_users.aws_iam_group.user_group[1] will be created
  + resource "aws_iam_group" "user_group" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "Ops"
      + path      = "/"
      + unique_id = (known after apply)
    }

  # module.iam_create_users.aws_iam_group_policy_attachment.assume_role_policy_attachment[0] will be created
  + resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment" {
      + group      = "Developers"
      + id         = (known after apply)
      + policy_arn = (known after apply)
    }

  # module.iam_create_users.aws_iam_group_policy_attachment.assume_role_policy_attachment[1] will be created
  + resource "aws_iam_group_policy_attachment" "assume_role_policy_attachment" {
      + group      = "Ops"
      + id         = (known after apply)
      + policy_arn = (known after apply)
    }

  # module.iam_create_users.aws_iam_policy.assume_role_policy[0] will be created
  + resource "aws_iam_policy" "assume_role_policy" {
      + arn         = (known after apply)
      + description = "Allows the role Developers to be assumed."
      + id          = (known after apply)
      + name        = "assume-role-Developers"
      + path        = "/"
      + policy      = (known after apply)
    }

  # module.iam_create_users.aws_iam_policy.assume_role_policy[1] will be created
  + resource "aws_iam_policy" "assume_role_policy" {
      + arn         = (known after apply)
      + description = "Allows the role Ops to be assumed."
      + id          = (known after apply)
      + name        = "assume-role-Ops"
      + path        = "/"
      + policy      = (known after apply)
    }
  # module.iam_create_users.aws_iam_user_group_membership.this["Santiago"] will be created
  + resource "aws_iam_user_group_membership" "this" {
      + groups = [
          + "Ops",
        ]
      + id     = (known after apply)
      + user   = "Santiago"
    }

Plan: 20 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------
```

