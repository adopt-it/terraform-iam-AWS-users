variable "allowed_roles" {
  description = "The roles that this group is allowed to assume."
  type        = list(string)
}

variable "users" {
  description = "A hash map of users and their details. Also, the keys are user names, whereas the inner keys are defined in the terraform documentation."
  type = map(object({
    path                 = string
    force_destroy        = bool
    group_memberships    = list(string)
  }))
}