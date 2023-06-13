resource "aws_organizations_account" "this" {
  name  = var.account_name
  email = var.account_email

  close_on_deletion = true
  role_name         = "OrganizationAccountAccessRole"

}