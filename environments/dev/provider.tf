provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Environment     = "dev"
      Project         = "3-tier"
      Author          = "aws-default-tags"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "dev-3-tier-tf-state-bucket-mumba"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "dev-3-tier-tf-lock-table"
  }
}
