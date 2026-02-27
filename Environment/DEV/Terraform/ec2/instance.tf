resource "aws_instance" "web" {
  ami                    = data.aws_ami.example.id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.name
  }
}

data "aws_ami" "example" {
  owners      = ["679593333241"]
  most_recent = true
  name_regex  = "CentOS-Stream-9-20250604.1.x86_64-aba856bc-78bf-441c-b25c-980bec33a53f"
}


resource "aws_security_group" "sg" {
  name        = var.name
  description = "Allow TLS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.name
  }
}

variable "name" {}

output "public_ip" {
  value = aws_instance.web.public_ip
}