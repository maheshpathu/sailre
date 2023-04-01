terraform {
  required_providers{
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-south-1"  
}
resource "aws_instance" "sailorec2instance" {
  instance_type = "t2.micro"
  ami = "ami-068257025f72f470d"
  key_name = aws_key_pair.sailorkeypair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sailorsg.id]
}
resource "aws_key_pair" "sailorkeypair" {
  key_name = "sailorkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVTStZPSiNizq6AX4ycOo81XZVmM50wYKqbgSYdbfuYpYadnAA6ipACOX2ev911VQJP9/KLhvP2+pMFvXKNLV/rBNo3zfjg8r+qmLxJG7IEzOdHvG0sk3lFUv8B3b/p0YzvNbVHtW0KYQ2dGJx6yNfTva6y7Za/bGUZNwU48AMEj4ej0aw7ok+vc8Lop7p6dbTktJMjKuFTsPuTLlUGHsKfutLuqC0TqD1jDhzeoHKfrCDmRya+JZ9n42N0Hk4ilCMH+XM4RiaanixCQyu/3DSbUe9dSKf5lxTCa7yUldrhyrvgeA32ns/a68aU7BylrgTw6KEA5UbqLO48jyQIcjSYetJyz/ytef9QJpOisO3IfRZn/D7adPfGF2eX56jrWvInF3ZGfBV2O45ywVyOkYiWqZdvyW8GBsUc2qBsEdxHI9Hx3740S8ke2fHb/tiYC5fNirCxCOlfhed/83ewrgq53SIg18rOcJeAVDE9SDUi4KEvHUdr6PJgVR0RuTrzRk= prathyusha mahesh@LAPTOP-VJJH8NAC"
}
resource "aws_security_group" "sailorsg" {
    ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = -1
      self = false
      to_port = 0
    } 
  
}