terraform {
    required_providers {
        docker = {
          source    = "kreuzwerker/docker"
          version   = "3.0.1"
        }
    }
}
provider "docker" { 
}

resource "docker_image" "mi_imagen" {
    name            = "rastasheep/ubuntu-sshd:18.04"
}

resource "docker_container" "mi_contenedor" { 
    name            = "micontenedorPruebas" 
    image           = docker_image.mi_imagen.image_id
}

module "pruebas" {
    source          = "../test"
    host            = "calcetinsudao"
    ping            = {}
}