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
|region||Amazon AWS region to use for running terraform scripts|
|role_name||Sample role to be created for the different users to be able to assume automatically|
|users||A hash map of users and their details to be added. Also, the keys are user names, whereas the inner keys are defined in the terraform documentation.|



