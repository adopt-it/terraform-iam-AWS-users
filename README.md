# Terraform project for deploying a web application by creating the underlying infrastructure

## Background & Tasks

-   Implementing a terraform configuration to create the required infrastructure on AWS.
-   Using terraform to 'deploy' the index.html ( application ) on the AWS infrastructure.
-   Ensuring that the application can only be accessed from: 3.121.56.176
-   The terraform scripts also create a VPC with two subnets and deploy a light web application which includes an application load balances, Security groups
    and ubuntu 20.04 EC2 instances.
    - Apache Web Server has been used to execute the application.

## Prerequisites 📋


First, some things you will need:

```
Terraform at least v0.13.4 
You should have a profile configured in your ~/.aws/credentials file
An Amazon AWS account 
```

For reference, the terraform scripts were run by using MacOS Mojave

## Variables 🔧
In order to execute properly, we have to first define some variables within [variables.tf](variables.tf) on the root directory:
| Template | Description |
| --- | --- | 
| public_key_path | Enter the path to the SSH Public Key to add to AWS. |
| aws_region | Amazon AWS region to use for running terraform scripts. |
| cidr_blocks | Hosts being permitted to access the application |
| vpc_cidr_block | VPC cidr block |

in the [instances module](instances/variables.tf), you can also configure the instance default AMI which points to the ubuntu 20.04.

## How to use 📦
1. Make sure to configure your amazon credentials with ```aws configure```.

2. After cloning the repository, at the root level, execute:
``` 
terraform init 
```
to install any dependencies and modules required.


3. Edit the file [variables.tf](variables.tf) with the required values for the infrastructure deployment.


4. Make sure to proceed first with a dry-run approach to list down the activities and resources from terraform:
```
terraform plan
```
which will give an output like the following one to list out the actions to be performed:
```
➜  terraform-iam-AWS-users git:(main) ✗ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

------------------------------------------------------------------------
....
```

5. After revising the terraform actions, run the following to trigger the terraform scripts.
```
terraform apply
```
which will apply the terraform configuration to deploy the infrastructure.
```
resource "aws_instance" "instance" {
    ami                          = "ami-0d971d62e4d019dcc"
    arn                          = "arn:aws:ec2:eu-central-1:488598619227:instance/i-0aa998cfa400430c9"
    associate_public_ip_address  = true
.....
```

6. If you want to remove the terraform resources from AWS cloud, you can easily run:
```
terraform destroy
```

The project was elaborated with open source technologies and the idea has been to treat the infrastructure as code by deploying the whole VPC landscape including the different configurations for ALB, EC2, Security groups, etc.
## Built With 🛠️
* [Terraform](https://www.terraform.io/) - Delivering infrastructure as code with Terraform.
* [Amazon Web Services (AWS)](https://aws.amazon.com/console/) - AWS Cloud and Everything you need to access and manage the same.
## Authors ✒️

* **Carlos Klinsmann** - *First Version*.

## Acknowledgements 🎁

* Github API & valuable resources.
* Inspiration on the [GithHub template](https://gist.githubusercontent.com/Villanuevand/6386899f70346d4580c723232524d35a/raw/8028158f59ba1995b0ca1afd3173bac3df539ca0/README-espa%25C3%25B1ol.md) 
* Terraform documentation.
