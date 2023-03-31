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
  key_name      = aws_key_pair.mis_claves.key_name  # GUAY !!!!!

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
