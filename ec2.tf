 # Creates EC2 SPOT Instance
resource "aws_spot_instance_request" "spot" {
  ami                        = data.aws_ami.image.id
  instance_type              = "t3.micro"
  vpc_security_group_ids     = 
  wait_for_fulfillment       = true

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}