output "users" {
  description = "A dictionary/hash map of user resources, with user name as the key, and each value map containing the user's ARN and Unique ID."
  value = {
    for user, properties in aws_iam_user.this : user => {
      arn : properties.arn
      unique_id : properties.unique_id
    }
  }
}