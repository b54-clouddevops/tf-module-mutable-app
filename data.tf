data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b54-tf-remote-state"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}


data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "b54-tf-remote-state"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# Ensure you create an AMI : Using my my Lab Image [ create an instance, Install Ansible and Make an AMI and use it]
data "aws_ami" "image" {
  most_recent      = true
  name_regex       = "ansible-lab-image"     # Ensure you make your own AMI from my labImage and install ANSIBLE on the top of it and then use your AMI Name
  owners           = ["self"]
}
