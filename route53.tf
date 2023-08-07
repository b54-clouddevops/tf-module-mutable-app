resource "aws_route53_record" "dns_record" {
  zone_id = LB_TYPE == internal ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID 

  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = LB_TYPE == internal ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRES ] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ADDRESS]
}