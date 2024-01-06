module "my_ec2_module"{
    source= "./modules/ec2/"
    instanceType = "t3.micro"
}

# module "my-s3-bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "3.15.1"
#   bucket = "gfgbucketterraform"
# }

output "myouput"{
    value = module.my_ec2_module.public_ip
}