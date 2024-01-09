resource "aws_instance" "web" {
  count = 3
  depends_on = [aws_key_pair.my_key_pair, aws_security_group.webserver_sg ]
  ami   = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instanceType
  tags = {
    Name = "${var.instanceTagName}-${count.index}"
  }
  key_name = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  provisioner "local-exec" {
    command = "echo 'resource exectued succesfully'"
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "testkeygfg"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_key_pair" "my_key_pair123" {
  key_name   = "testkeygfg123"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "webserver_sg" {
  name        = var.sg_name
  description = "Webserver Security Group Allow port 80"
  vpc_id      = data.aws_vpcs.default_vpc.ids[0]

  dynamic "ingress" {
    for_each = var.sg_allow_ports
    content { 
    description      = "---"
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "null_resource" "configureAnsibleInventory" {
triggers ={
  mytrigger = timestamp()
}
provisioner "local-exec" {
    command = "echo [prod] > inventory"
  }

}
resource "null_resource" "configureansibleinventoryIPdetails"{
count =3
triggers ={
  mytrigger = timestamp()
}
provisioner "local-exec" {
    command = "echo ${aws_instance.web[count.index].public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=gfgkey >> inventory"
  }
}

resource "null_resource" "destroy_resource"{
  provisioner "local-exec" {
    when = destroy
    command = "echo destroying resources.. > gfgdestroy.txt"
  }
}
