#Specify amazon AWS region 
variable "region" {
  type = string
  default = "eu-central-1"
}

#Variable for indicating the role name to be created
variable "role_name" {
  type    = string
  default = "InfraUsers"
}

#Users & groups to be added
variable "users" {
  description = "A hash map of users and their details. Also, the keys are user names, whereas the inner keys are defined in the terraform documentation"
  type = map(object({
    path                 = string
    force_destroy        = bool
    group_memberships    = list(string)
   }))

default = {
"Eugene" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Developers"]
}
"Milo" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Developers"]
}
"Abigail" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Developers"]
}

"Aidan" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Developers"]
}

"Santiago" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Ops"]
}

"Felix" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Ops"]
}

"Morgan" = {
    "path" = "/"
    "force_destroy" = true
    "group_memberships" = ["Ops"]
}

}

}
