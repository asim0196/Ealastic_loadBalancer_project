############ ec2 ##########

resource "aws_instance" "firstec2" {
  ami           = "ami-0126086c4e272d3c9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet.id
  key_name      = "mykey"
  security_groups = [aws_security_group.SG.id]
  user_data = file("httpd.sh")
  tags          = { Name = "myterraformec2" }
  
}

############ ec2 2nd ##########

resource "aws_instance" "secondec2" {
  ami           = "ami-0126086c4e272d3c9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id
  key_name      = "mykey"
  security_groups = [aws_security_group.SG.id]
  user_data = file("httpd.sh")
  tags          = { Name = "myterraformec2_2nd" }
  
}


########### load balancer ###########
resource "aws_elb" "LB" {
  name               = "myloadbalancer"
  subnets = [ aws_subnet.subnet.id,aws_subnet.subnet2.id ]
  security_groups = [aws_security_group.SG.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }


instances                   = [aws_instance.firstec2.id , aws_instance.secondec2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

tags = {
    Name = "myloadBalance"
  }
}


