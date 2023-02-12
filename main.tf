terraform { 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0" }
  } 
}

locals {
  ami_id = "ami-08fdec01f5df9998f" # For simplicity we are using a hardocded ami.
  ssh_user = "ubuntu"  
}

/* This is how the AMI ID should ideally be fetched.
data "aws_ami" "example" { 
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
    most_recent = true 
}

output "myami" {
  value = data.aws_ami.example.image_id
}
*/

#Resource to create a SSH private key
resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Resource to Create Key Pair
resource "aws_key_pair" "wpserver" {
  key_name   = "ssh-keypair"
  public_key = tls_private_key.pvtkey.public_key_openssh
}

provider "aws" {
  access_key = "<your_access_key>"
  secret_key = "<your_secret_key>"
  token = "" # If you need it
  region = ""
}

resource "aws_security_group" "wpserversg" {
  name = "wpserversg"
  # vpc_id = local.vpc_id # If you have custom VPC

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2wpserver" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.wpserversg.id]
  key_name = aws_key_pair.wpserver.key_name

  tags = {
    Name = "WordPress Server"
  }
}

# Creating a local hosts file for Ansible to use
resource "local_file" "hosts" {
  content = templatefile("${path.module}/templates/hosts",
    {
      public_ipaddr = aws_instance.ec2wpserver.public_ip
      ansible_user = local.ssh_user
    }
  )
  filename = "${path.module}/hosts"
}

# We will use a null resource to execute the playbook with a local-exec provisioner.

resource "null_resource" "run_playbook" {
  depends_on = [

    # Running of the playbook depends on the successfull creation of the EC2
    # instance and the local inventory file.

    aws_instance.ec2wpserver,
    local_file.hosts,
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i hosts playbook.yml"
  }
}
