terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_instance" "mi_servidor" {
  ami           = data.aws_ami.mi_imagen.image_id
  instance_type = "t2.micro"
  #key_name      = "claves-prueba-${var.nombre_despliegue}" 
                    # CAGADA !!!!! RUINA !!! MIERDULI GIGANTE !!!!
                    # Va a funcionar esto?
                    #  SI = III
                    #  NO = II
                    #  NS/NC = I
                    #  NC = Ivan (pero si sabe)
  #depends_on = [aws_key_pair.mis_claves] # ESTO ES UNA MIERDA Y MUY MALA PRACTICA PDE HECHO !!!
  key_name          = aws_key_pair.mis_claves.key_name  # GUAY !!!!!
  security_groups   = [aws_security_group.mi_security_group.name]
  
  tags = {
        Name = "maquina-${var.nombre_despliegue}"
  }
}

data "aws_ami" "mi_imagen" {
  most_recent      = true
  #name_regex       = "^myami-\\d{3}"
  owners           = ["099720109477"] # ID de Canical

  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "claves_ssh" {
    source = "../claves_ssh"
}

resource "aws_key_pair" "mis_claves" {
  key_name   = "claves-prueba-${var.nombre_despliegue}"
  public_key = module.claves_ssh.publicKey.openssh
}

resource "aws_security_group" "mi_security_group" {

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
        Name = "security-group-${var.nombre_despliegue}"
  }
}

module "pruebas" {
    source          = "../test"
    host            = "${aws_instance.mi_servidor.public_ip}"
    ping            = {}
    ssh_connection  = {
                            user       = "ubuntu"
                            privateKey = module.claves_ssh.privateKey.pem
                        }
}

output "resultado_ping"{
    value = module.pruebas.ping_test
}