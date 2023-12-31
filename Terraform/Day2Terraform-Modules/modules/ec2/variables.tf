variable "instanceType"{
type = string
default = "t2.micro"
}

variable "x"{
    type = string
    default = "hello"
}

variable "instanceTagName"{
    type = string
    default = "GFGTerraform"
}

variable "amiID"{
    default ="ami-0a0f1259dd1c90938"
}

variable "sg_name"{
    default = "WebserverSg"
}

variable sg_allow_ports{
    type= list
    default = [80,22,8080,81,85,9090,9191]
}