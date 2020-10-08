# AWS Identity and Access Management (IAM) with Terraform (a sample use case)

### Background

Terraform modules & scripts to create user, groups & roles within AWS IAM. 

Moreover, let us say we have two groups of users. The first group - "Developers", with users: Eugene,
Milo, Abigail, Aidan. The second group - "Ops", with users: Santiago, Felix, Morgan.

Furthermore, we want to achive the following tasks:
1. Writing Terraform code which will:
- Create users and groups
- Assign users to the groups
- Create roles for each group (users should be able to assume them); not necessary to
assign any policies to the roles.

### Prerequisites 📋


First, some things you will need:

```
Ansible at least 2.7
Amazon console api
An Amazon AWS account
IAM credentials to login to the AWS account (will be provided)
Python 3+
Virtualenv
```

For reference, the webservice was deployed by using MacOS Mojave
