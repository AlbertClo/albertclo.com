terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

locals {
    common_tags = {
        Project     = "albertclo.com"
        Environment = "Production"
        ManagedBy   = "Terraform"
    }
}

resource "aws_internet_gateway" "albertclo_igw" {
    vpc_id = aws_vpc.albertclo_vpc.id

    tags = merge(local.common_tags, {
        Name = "albertclo-igw"
    })
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.albertclo_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.albertclo_igw.id
    }

    tags = merge(local.common_tags, {
        Name = "albertclo-public-rt"
    })
}

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.albertclo_subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_vpc" "albertclo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = merge(local.common_tags, {
        Name = "albertclo-vpc"
    })
}

resource "aws_subnet" "albertclo_subnet" {
    vpc_id                  = aws_vpc.albertclo_vpc.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags = merge(local.common_tags, {
        Name = "albertclo-subnet"
    })
}

resource "aws_key_pair" "albert_ssh_key" {
    key_name   = "albert_ssh_key"
    public_key = file("public_keys/albert_id_rsa.pub")

    tags = merge(local.common_tags, {
        Name = "albert_ssh_key"
    })
}

resource "aws_security_group" "albertclo_com_sec_group" {
    name        = "albertclo_com_sec_group"
    description = "Allow inbound web and ssh traffic"
    vpc_id      = aws_vpc.albertclo_vpc.id

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH from personal IPs"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["197.245.68.172/32"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.common_tags, {
        Name = "albertclo-com-sec-group"
    })
}

data "aws_ssm_parameter" "amzn2_ami" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "albertclo_com" {
    ami           = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t3.micro"

    key_name = aws_key_pair.albert_ssh_key.key_name

    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.albertclo_com_sec_group.id]
    subnet_id              = aws_subnet.albertclo_subnet.id

    root_block_device {
        volume_type = "gp3"
        volume_size = 20  # Size in GB
        encrypted   = true
        tags = merge(local.common_tags, {
            Name = "Root volume for albertclo.com"
        })
    }

    user_data = <<-EOF
                #!/bin/bash

                sudo yum update -y
                sudo yum install -y docker

                sudo amazon-linux-extras install docker

                sudo usermod -a -G docker ec2-user

                sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose

                sudo service docker start
                sudo systemctl enable docker

                sudo usermod -a -G docker $USER

                EOF

    lifecycle {
        # prevent_destroy = true
        ignore_changes  = [
            ami,
        ]
    }

    tags = merge(local.common_tags, {
        Name = "albertclo.com"
    })
}

output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value       = aws_instance.albertclo_com.public_ip
}
