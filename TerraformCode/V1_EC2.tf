provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "TeamProject" {
    ami = "ami-03d294e37a4820c21"
    instance_type = "t2.micro"
    key_name = "Project_one_key"
}