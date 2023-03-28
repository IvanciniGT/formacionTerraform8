terraform {
    required_providers {
        docker = {
          source = "kreuzwerker/docker"
          version   = "3.0.1"
        }
    }
}

provider "docker" { 
}


# Variable docker_image.mi_imagen que me devuelve?
# UN RECURSO DE TIPO docker_image
# AL QUE LE PUEDO PEDIR... lo que tenga definido en el SCHEMA
# ofrecido por el proveedor (docu)
resource "docker_image" "mi_imagen" {
    name            = "nginx:latest"
}

# Variable docker_container.mi_contenedor que me devuelve?
# UN RECURSO DE TIPO docker_container? NO
# Al haber usao el count, devuelve una 
# LISTA DE RECURSOS DE TIPO docker_container
resource "docker_container" "mi_contenedor" { 
    count           = var.numero_de_contenedores # Aqui pasamos un número
                      # Cuando usamos la palabra count, terraform em regala
                      # La variable count.index
                      # Esa variable me dice por el que voy
    name            = "minginx_${count.index}" 
    image           = docker_image.mi_imagen.image_id 
    ports {
        internal    = 80           
        external    = 8080 + count.index
        ip          = "127.0.0.1"
    }
}