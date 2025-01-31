terraform {
  backend "s3" {
    bucket         = "terraform-state-02" # Replace with your S3 bucket
    key            = "youtube-sentiment-analysis/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}

variable "docker_image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b9064170e32bde34" # Updated Amazon Linux 2 AMI for us-east-2
  instance_type = "t2.micro"
  key_name      = "mlflow" # Replace with your key pair

  user_data = templatefile("user_data.sh.tpl", {
    docker_image_tag = var.docker_image_tag
  })

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "youtube-sentiment-analysis"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}