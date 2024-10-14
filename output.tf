resource "time_sleep" "wait" {
  create_duration = "30s"
}

data "aws_instances" "running_instances" {
  depends_on = [time_sleep.wait]

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

output "running_instance_public_ips" {
  value = ["public_ips" ,"${data.aws_instances.running_instances.public_ips}", 
  "private_ips" ,"${data.aws_instances.running_instances.private_ips}"]
}