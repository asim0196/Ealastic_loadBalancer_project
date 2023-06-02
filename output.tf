output "loadbalance" {
  value = aws_elb.LB.dns_name
}
  