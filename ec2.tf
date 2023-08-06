 # Creates EC2 SPOT Instance
resource "aws_spot_instance_request" "spot" { 
  count                      = var.SPOT_INSTANCE_COUNT

  ami                        = data.aws_ami.image.id
  instance_type              = var.SPOT_INSTANCE_TYPE
  vpc_security_group_ids     = [aws_security_group.allows_app.id]
  subnet_id                  = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  wait_for_fulfillment       = true

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}


# Creates On-demand Backend Component
resource "aws_instance" "od" {
  count                      = var.OD_INSTANCE_COUNT

  ami                        = data.aws_ami.image.id
  instance_type              = var.OD_INSTANCE_TYPE
  vpc_security_group_ids     = [aws_security_group.allows_app.id]
  subnet_id                  = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)

  # This will be executed on the top of the machine once it's created
#   provisioner "remote-exec" {

#     # connection block establishes connection to this
#     connection {
#       type     = "ssh"
#       user     = "centos"
#       password = "DevOps321"
#       host     = self.private_ip             # aws_instance.sample.private_ip : Use this only if your provisioner is outside the resource.
#     }

#     inline = [
#       "ansible-pull -U https://github.com/b54-clouddevops/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
#     ]
#   }
}