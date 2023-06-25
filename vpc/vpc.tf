# Declaring the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQKX7OL4VGQYGMTVH"
  secret_key = "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"

}


resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}