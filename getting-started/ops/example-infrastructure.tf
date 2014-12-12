provider "atlas" {
    token = "ATLAS_TOKEN_HERE"
}

provider "aws" {
    access_key = "ACCESS_KEY_HERE"
    secret_key = "SECRET_KEY_HERE"
    region = "us-east-1"
}

resource "aws_elb" "web" {
    name = "terraform-example-elb"

    # The same availability zone as our instances
    availability_zones = ["${aws_instance.web.*.availability_zone}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    # The instances are registered automatically
    instances = ["${aws_instance.web.*.id}"]
}


resource "aws_instance" "web" {
    instance_type = "t1.micro"
    ami = "ami-408c7f28"

    # This will create 2 instances
    count = 2
}