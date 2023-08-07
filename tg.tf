# Creates Target Group of the Backend Component
resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.VPC_ID
}

# Attach the TargetGroup to the ALB ( frontend-tg should be attached to Public ALB and backend-tg's should go and attach to Public ALB) 
resource "aws_lb_target_group_attachment" "attach_instances" { 
  count            = local.INSTANCE_COUNT

  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_IDS, count.index)
  port             = 8080
}