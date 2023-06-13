provider "aws" {
  region  = "us-east-1"
  profile = "example-main-account-profile"
}


module "account" {

  source = "../.."

  account_name  = "example-account"
  account_email = "sampple-email-account@domain.tld"

}

provider "aws" {
  alias   = "new-account-provider"
  region  = "us-east-1"
  profile = "example-new-account-profile"
  assume_role {
    role_arn = "arn:aws:iam::${module.account.account_id}:role/OrganizationAccountAccessRole"
  }
}

# Simple resource to test the new account provider and the new account
resource "aws_vpc" "test" {
  provider   = aws.new_account
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "test vpc"
  }

}