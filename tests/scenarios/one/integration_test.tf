terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  endpoints {
    lambda           = "http://localhost:5000"
    s3               = "http://localhost:5000"
    sns              = "http://localhost:5000"
    sqs              = "http://localhost:5000"
    ses              = "http://localhost:5000"
    cloudwatch       = "http://localhost:5000"
    cloudwatchlogs   = "http://localhost:5000"
    cloudwatchevents = "http://localhost:5000"
    sts              = "http://localhost:5000"
    iam              = "http://localhost:5000"
    kms              = "http://localhost:5000"
  }
}

// If the Lambda function is installed in a non-master/mgmt account, it can
// list all accounts and inventory each one using the OrganizationAccessRole
// if accounts_info = "" and master_account_id and master_role_name are set
// and the roles are assumable by the Lambda function's IAM role
module "integration_test" {
  // source            = "github.com/GSA/grace-inventory?ref=latest"
  source            = "../../../"
  accounts_info     = "self"
  project_name      = "grace"
  appenv            = var.appenv
  master_account_id = var.master_account_id
  master_role_name  = var.master_role_name
  tenant_role_name  = var.tenant_role_name
  source_file       = "../../../release/grace-inventory-lambda.zip"
}
