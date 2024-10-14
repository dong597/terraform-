resource "aws_instance" "instance_web" {
    ami = "ami-0ac6b9b2908f3e20d"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.web.id
    vpc_security_group_ids = [aws_security_group.instance_web.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.aws_key.key_name
    count = 2

    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt -y install nginx
              echo 'Eden Hazard Blues legend' > /var/www/html/index.html
              systemctl start nginx
              EOF

    tags = {
        Name = "terraform-instance_web-${count.index}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_instance" "instance_ansible" {
    ami = "ami-0ac6b9b2908f3e20d"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.mgmt.id
    vpc_security_group_ids = [aws_security_group.instance_ansible.id]
    associate_public_ip_address = true
    key_name = aws_key_pair.aws_key.key_name

    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt -y install ansible
              EOF

    tags = {
        Name = "terraform-instance_ansible"
    }

    lifecycle {
        create_before_destroy = true
    }
}