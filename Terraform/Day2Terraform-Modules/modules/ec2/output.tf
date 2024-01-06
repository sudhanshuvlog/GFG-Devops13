output "outputofamiId"{
    value = data.aws_ami.latest_amazon_linux
}

output "output1"{
    value = var.x
}

output "vpc_id"{
    value = data.aws_vpcs.default_vpc
}

output "public_ip"{
value = aws_instance.web.public_ip
}