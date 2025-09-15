provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-32-4-d33s8f1ntdlhbpdsdc4g-4566.direct.lab-boris.fr"
  }
}

variable "commit_sha" {
  description = "The commit SHA that triggered this deployment"
  type        = string
}

# Use the commit SHA to select a unique AMI, or build a new one
resource "aws_instance" "example" {
  ami           = "ami-${var.commit_sha}" # Or use a data source to look up the AMI by tag
  instance_type = "t2.micro"
  tags = {
    Name        = "instance-${var.commit_sha}"
    CommitSHA   = var.commit_sha
  }
}
