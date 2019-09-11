provider "aws" {
    profile    = "automation_user"
    region     = var.region
    shared_credentials_file    = "/home/pauloeliasjr/.aws/credentials"
}

resource "aws_vpc" "service" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "service" {
    vpc_id = "${aws_vpc.service.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.service.id}"
}

resource aws_security_group "ssh_access" {
    name = "ssh_access"
    description = "Allow SSH traffic to support Ansible deployment"
    vpc_id = "${aws_vpc.service.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    
}
}

resource "aws_route_table" "default" {
    vpc_id = "${aws_vpc.service.id}"


    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = "${aws_vpc.service.id}"
  route_table_id = "${aws_route_table.default.id}"

}

resource "aws_key_pair" "deployer" {
    key_name = "deployer-key"
    public_key = var.ssh_key
}

resource "aws_instance" "exemplo" {
    ami    = var.ami_mapping[var.region]
    instance_type   = "t2.micro"
    key_name = "${aws_key_pair.deployer.id}"
    subnet_id = "${aws_subnet.service.id}"
    vpc_security_group_ids = ["${aws_security_group.ssh_access.id}"]
}