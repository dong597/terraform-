resource "aws_alb" "terraform_alb" {
    name = "terraformalb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.ALB.id]
    subnets = [aws_subnet.web.id , aws_subnet.backup.id]
    enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "web_target" {
  name     = "webtarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terrafom_vpc1.id
}

resource "aws_alb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.web_target.arn
  target_id = aws_instance.instance_web[0].id
  port = 80
}

resource "aws_alb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.web_target.arn
  target_id = aws_instance.instance_web[1].id
  port = 80
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.terraform_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target.arn
  }
}
