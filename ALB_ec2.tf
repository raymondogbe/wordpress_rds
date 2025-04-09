#ALB
resource "aws_lb" "wp_lb" {

  name = "wp-lb"

  internal = false

  load_balancer_type = "application"

  security_groups = [aws_security_group.wp_sg.id]

  subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

}




#DEFINE TARGET GROUPS
resource "aws_lb_target_group" "wordpress_target_group" {

  name = "wordpress-target-group"

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.wp_vpc.id



  health_check {

    path = "/"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

    matcher = "200"

  }

}



# Define listener or target group to ALB 
resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = aws_lb.wp_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  }
}
#Attach target group to instance
resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  target_id        = aws_instance.wp_instance.id
  port             = 80
  depends_on = [
    aws_instance.wp_instance,
  ]
}
#Attach target group to instance
resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.wordpress_target_group.arn
  target_id        = aws_instance.wp_instance2.id
  port             = 80
  depends_on = [
    aws_instance.wp_instance2,
  ]
}




/* resource "aws_lb_target_group" "test" {
  # ... other configuration ...
}

resource "aws_instance" "test" {
  # ... other configuration ...
} */