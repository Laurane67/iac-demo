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

resource "random_id" "instance" {
  byte_length = 4
}

resource "aws_instance" "example" {
  ami           = "ami-123456" # or your AMI selection logic
  instance_type = "t2.micro"
  tags = {
    Name = "instance-${random_id.instance.hex}"
  }
}
