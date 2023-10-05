provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "TeamProject-instance" {
  ami           = "ami-03d294e37a4820c21"
  instance_type = "t2.micro"
  key_name      = "Project_one_key"
  subnet_id     = aws_subnet.public-subnet-01.id
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]

<<<<<<< HEAD
  for_each = toset(["Jenkins-Master", "Jenkins-Slave", "Ansible"])
=======
  for_each = toset(["jenkins-master", "jenkins-slave", "ansible"])
>>>>>>> 7f1630c5a25112d18d866051a6f2b0bd69edeb09
   tags = {
     Name = "${each.key}"
   }
}

resource "aws_security_group" "ssh-sg" {
    name = "SSHSG"
    description = "ssh access"
    vpc_id = aws_vpc.tp-vpc.id 
  

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

   ingress {
    description      = "jenkins access"
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
    Name = "SSHSG"
  }
}  

resource "aws_vpc" "tp-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "TPVPC"
  }
  
}

resource "aws_subnet" "public-subnet-01" {
  vpc_id = aws_vpc.tp-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "PUBLICSUBNET01"
  }
}

resource "aws_subnet" "public-subnet-02" {
  vpc_id = aws_vpc.tp-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "PUBLICSUBNET01"
  }
}

resource "aws_internet_gateway" "tp-igw" {
  vpc_id = aws_vpc.tp-vpc.id 
  tags = {
    Name = "TPIGW"
  } 
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.tp-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tp-igw.id 
  }
}

resource "aws_route_table_association" "rta-public-subnet-01" {
  subnet_id = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.public-rt.id   
}

resource "aws_route_table_association" "rta-public-subnet-02" {
  subnet_id = aws_subnet.public-subnet-02.id 
  route_table_id = aws_route_table.public-rt.id   
}
