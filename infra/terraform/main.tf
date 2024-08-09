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

# Creates an Internet Gateway for the VPC to allow internet access
resource "aws_internet_gateway" "albertclo_igw" {
    vpc_id = aws_vpc.albertclo_vpc.id

    tags = merge(local.common_tags, {
        Name = "albertclo-igw"
    })
}

# Creates a public route table for the VPC
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

# Associates the public route table with the subnet
resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.albertclo_subnet.id
    route_table_id = aws_route_table.public.id
}

# Creates a VPC for the infrastructure
resource "aws_vpc" "albertclo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = merge(local.common_tags, {
        Name = "albertclo-vpc"
    })
}

# Creates a subnet within the VPC
resource "aws_subnet" "albertclo_subnet" {
    vpc_id                  = aws_vpc.albertclo_vpc.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags = merge(local.common_tags, {
        Name = "albertclo-subnet"
    })
}

# Creates an SSH key pair for accessing EC2 instances
resource "aws_key_pair" "albert_ssh_key" {
    key_name   = "albert_ssh_key"
    public_key = file("public_keys/albert_id_rsa.pub")

    tags = merge(local.common_tags, {
        Name = "albert_ssh_key"
    })
}

# Generates an IAM user and access key for GitHub Actions
resource "aws_iam_user" "albertclo_github_actions_user" {
    name = "albertclo-github-actions"

    tags = merge(local.common_tags, {
        Name = "albertclo-github-actions"
    })
}

# Creates a policy to allow running SSM commands on the EC2 instance. Used for deployments with GitHub Actions.
resource "aws_iam_policy" "albertclo_github_actions_ssm_policy" {
    name        = "albertclo-github-actions-ssm-policy"
    description = "Policy to allow running SSM commands on albertclo.com EC2 instance"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "ssm:SendCommand",
                    "ssm:GetCommandInvocation"
                ]
                Resource = [
                    "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/${aws_instance.albertclo_com.id}",
                    "arn:aws:ssm:*:*:document/AWS-RunShellScript"
                ]
            },
            {
                Effect = "Allow"
                Action = [
                    "ssm:DescribeInstanceInformation",
                    "ec2:DescribeInstanceStatus"
                ]
                Resource = "*"
            }
        ]
    })
}

# Attaches the SSM policy to the GitHub Actions user
resource "aws_iam_user_policy_attachment" "albertclo_github_actions_ssm_policy_attachment" {
    user       = aws_iam_user.albertclo_github_actions_user.name
    policy_arn = aws_iam_policy.albertclo_github_actions_ssm_policy.arn
}

# Creates an access key for the GitHub Actions user
resource "aws_iam_access_key" "albertclo_github_actions_access_key" {
    user = aws_iam_user.albertclo_github_actions_user.name
}

# Creates a security group to control inbound and outbound traffic
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

# Retrieves the latest Amazon Linux 2 AMI ID
data "aws_ssm_parameter" "amzn2_ami" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Retrieves information about the current AWS region
data "aws_region" "current" {}

# Creates an EC2 instance for hosting albertclo.com
resource "aws_instance" "albertclo_com" {
    ami           = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t3.micro"

    key_name = aws_key_pair.albert_ssh_key.key_name

    associate_public_ip_address = true
    vpc_security_group_ids      = [aws_security_group.albertclo_com_sec_group.id]
    subnet_id                   = aws_subnet.albertclo_subnet.id

    root_block_device {
        volume_type = "gp3"
        volume_size = 20  # Size in GB
        encrypted   = true

        tags = merge(local.common_tags, {
            Name = "Root volume for albertclo.com"
        })
    }

    iam_instance_profile = aws_iam_instance_profile.albert_clo_ec2_profile.name

    user_data = <<-EOF
                #!/bin/bash

                # Install required software
                sudo yum update -y
                sudo yum install -y docker
                sudo yum install -y git
                sudo amazon-linux-extras install docker
                sudo usermod -a -G docker ec2-user
                sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose

                # Start docker
                sudo service docker start
                sudo systemctl enable docker
                sudo usermod -a -G docker $USER

                # Setup GitHub deploy key
                aws ssm get-parameter --name "/albertclo/github_deploy_key" --with-decryption --region ${data.aws_region.current.name} --output text --query Parameter.Value > /home/ec2-user/.ssh/github_deploy_key
                chmod 600 /home/ec2-user/.ssh/github_deploy_key
                chown ec2-user:ec2-user /home/ec2-user/.ssh/github_deploy_key
                ssh-keyscan github.com >> /home/ec2-user/.ssh/known_hosts
                cat <<EOT >> /home/ec2-user/.ssh/config
                Host github.com
                  IdentityFile /home/ec2-user/.ssh/github_deploy_key
                  IdentitiesOnly yes
                EOT
                chown ec2-user:ec2-user /home/ec2-user/.ssh/config
                chmod 600 /home/ec2-user/.ssh/config

                # Clone albertclo.com repo from GitHub
                # Creating this directory and cloning into it can be delayed sometimes. So if you SSH into the server
                # immediately after creation and it's not there, wait a few minutes for it to appear.
                sudo mkdir -p /opt/albertclo.com
                sudo chown ec2-user:ec2-user /opt/albertclo.com
                sudo -u ec2-user git clone git@github.com:AlbertClo/albertclo.com.git /opt/albertclo.com 2>&1 | tee /tmp/git_clone_log.txt

                # Start amazon-ssm-agent
                # This is used by GitHub actions for deployments. So that GitHub doesn't need SSH access.
                sudo systemctl enable amazon-ssm-agent
                sudo systemctl start amazon-ssm-agent

                EOF

    lifecycle {
        # You can comment `prevent_destroy = true` if you want to recreate this EC2 instance.
        # Be aware that this instance runs the database on its host file system, so you'll need to backup and restore
        # the database if you do this. To force recreating this instance,
        # run `terraform taint aws_instance.albertclo_com` before running `plan` and `apply` again.
        prevent_destroy = true

        ignore_changes = [
            ami,
        ]
    }

    tags = merge(local.common_tags, {
        Name = "albertclo.com"
    })
}

# Retrieves information about the current AWS account
data "aws_caller_identity" "current" {}

# Generates a private key. Used as a GitHub deploy key for the albertclo.com repository.
resource "tls_private_key" "albertclo_github_deploy_key" {
    algorithm = "RSA"
    rsa_bits  = 4096

    lifecycle {
        prevent_destroy = true
    }
}

# Stores the GitHub deploy key in SSM Parameter Store
resource "aws_ssm_parameter" "albertclo_github_deploy_key" {
    name  = "/albertclo/github_deploy_key"
    type  = "SecureString"
    value = tls_private_key.albertclo_github_deploy_key.private_key_pem

    lifecycle {
        prevent_destroy = true
    }

    tags = merge(local.common_tags, {
        Name = "GitHub Deploy Key for albertclo.com"
    })
}

variable "github_repo" {
    description = "GitHub repository in the format owner/repo"
    type        = string
    default     = "AlbertClo/albertclo.com"
}

# Creates an IAM role for GitHub Actions to assume for deployments
resource "aws_iam_role" "albertclo_github_actions_role" {
    name = "albertclo-github-actions-deploy-role"

    assume_role_policy = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
                }
                Condition = {
                    StringLike = {
                        "token.actions.githubusercontent.com:sub" : "repo:${var.github_repo}:*"
                    }
                }
            }
        ]
    })
}

# Attaches a policy to the GitHub Actions role to allow deployments
resource "aws_iam_role_policy" "albertclo_github_actions_policy" {
    name = "albertclo-github-actions-deploy-policy"
    role = aws_iam_role.albertclo_github_actions_role.id

    policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
            {
                "Action" : [
                    "ec2:DescribeInstances",
                    "ec2:DescribeRegions",
                    "sts:GetCallerIdentity",
                    "sts:AssumeRole"
                ],
                "Effect" : "Allow",
                "Resource" : "*"
            },
            {
                "Action" : [
                    "ssm:SendCommand"
                ],
                "Condition" : {
                    "StringLike" : {
                        "ssm:ResourceTag/Name" : "albertclo.com"
                    }
                },
                "Effect" : "Allow",
                Resource = [
                    "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*"
                ]
            },
            {
                "Action" : [
                    "ssm:SendCommand"
                ],
                "Effect" : "Allow",
                "Resource" : [
                    "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:document/AWS-RunShellScript"
                ]
            }
        ]
    })
}

# Attaches the SSM Managed Instance Core policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ssm_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    role       = aws_iam_role.albert_clo_ec2_ssm_role.name
}

# Outputs the ARN of the GitHub Actions role
output "albertclo_github_actions_role_arn" {
    value = aws_iam_role.albertclo_github_actions_role.arn
}

# Outputs the public IP address of the EC2 instance
output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value       = aws_instance.albertclo_com.public_ip
}

# Outputs the AlbertClo EC2 instance ID
output "instance_id" {
    description = "ID of the EC2 instance"
    value       = aws_instance.albertclo_com.id
}

# Outputs the public key for GitHub deployment
output "github_public_key" {
    description = "GitHub deploy key"
    value       = tls_private_key.albertclo_github_deploy_key.public_key_openssh
}

# Outputs the access key for GitHub Actions
output "github_actions_access_key" {
    description = "Access key for GitHub Actions"
    value       = aws_iam_access_key.albertclo_github_actions_access_key.id
}

# Outputs the secret key for GitHub Actions
# This output is sensitive. To view this output, run `terraform output github_actions_secret_key`
output "github_actions_secret_key" {
    description = "Secret key for GitHub Actions"
    value       = aws_iam_access_key.albertclo_github_actions_access_key.secret
    sensitive   = true
}

