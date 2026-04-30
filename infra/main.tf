provider "aws" {
  region = "ap-south-1"
}

# Security Group
resource "aws_security_group" "betting_sg" {
  name        = "betting-sg1-final"
  description = "Allow SSH and App ports"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Frontend (React)"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Backend (Node)"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "betting-sg1-final"
  }
}

# EC2 Instance
resource "aws_instance" "betting_ec2" {
  ami           = "ami-0f58b397bc5c1f2e8"  # Amazon Linux (Mumbai)
  instance_type = "t3.micro"               # chargeable if not free tier

  key_name = "betting-key"  # ⚠️ must exist in AWS

  vpc_security_group_ids = [aws_security_group.betting_sg.id]

  tags = {
    Name = "Betting-App-Server"
  }
}