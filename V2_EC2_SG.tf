provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "TeamProject" {
    ami = "ami-03d294e37a4820c21"
    instance_type = "t2.micro"
    key_name = "Project_one_key"
    security_groups = ["TeamProjectSG"]
}

resource "aws_security_group" "TeamProject" {
    name = "TeamProjectSG"
    description = "SSH Access"

    ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   ingress {
    description      = "Jenkins"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tagprojectone"
  }
  
}