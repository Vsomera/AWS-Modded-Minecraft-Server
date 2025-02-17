terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "mc_ec2_key" {
  key_name   = "mc-ec2-key"
  public_key = file("~/.ssh/mc-ec2-key.pub")
}

resource "aws_instance" "mc_server_ec2" {
  ami           = "ami-0606dd43116f5ed57"     // ubuntu 22.04
  instance_type = "c5a.xlarge"                // 4vcpu, 8gb ram

  subnet_id     = aws_subnet.public_subnet.id
  iam_instance_profile = aws_iam_instance_profile.mc_instance_profile.name
  user_data = file("${path.module}/scripts/user_data.sh")

  vpc_security_group_ids = [aws_security_group.mc_server_sg.id]
  key_name = aws_key_pair.mc_ec2_key.key_name

  tags = {
    Name = "mc_server_ec2"
  }
}


resource "aws_s3_bucket" "mc_ec2_bucket" {
  bucket = "s3-bucket-name"                   // CHANGE S3 BUCKET NAME
  
  tags = {
    Name = "mc_ec2_bucket"
  }
}

resource "aws_s3_object" "setup_folder" {
  bucket = aws_s3_bucket.mc_ec2_bucket.id
  key    = "setup/"
}

