terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Creates a tiny, completely free/harmless resource to test the run
resource "aws_sns_topic" "demo_topic" {
  name = "se-demo-test-topic"
}

resource "aws_dynamodb_table" "tfc_example_table" {
  name         = "se-demo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Define the EC2 Instance resource at the root level
resource "aws_instance" "my_web_server" {
  ami           = "ami-0c7217cdde317cfec" # Ensure this matches a valid Amazon Linux 2/2023 AMI in us-east-1
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2-Example"
  }
}
