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
resource "docker_container" "mis_contenedores" { 
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
# (2)
# Cuando ataque a la variable docker_container.mis_contenedores_personalizados
# que me devuelve?
# UN RECURSO DE TIPO docker_container? NO
# UNA LISTA DE RECURSOS DE TIPO docker_container?  NO
# UNA MAPA DE RECURSOS DE TIPO docker_container, donde
# las claves de ese mapa serán las mismas claves que se contiene el mapa sobre elq ue se hace el for_each
resource "docker_container" "mis_contenedores_personalizados" { 
    for_each        = var.contenedores_personalizados 
                      # OJO!!! Este for_each es diferente del que 
                      # usábamos en los dynamic blocks
                      # En el caso de recursos, hemos de pasar:
                      # - Una lista de strings (lo cual sirve para muy poco)
                      # - Un mapa
                      # No puedo pasar una lista que no sea de strings
                      # Al usar for_each, terraform me regala la variable `each`
                      # A la que le podré pedir:
                      # - each.key
                      # - each.value
                      # OJO 2... ver (2)
    
    name            = each.key
    image           = docker_image.mi_imagen.image_id 
    ports {
        internal    = 80           
        external    = each.value
        ip          = "127.0.0.1"
    }
}

resource "docker_container" "mis_contenedores_mas_personalizados_desde_mapa" { 
    for_each        = var.contenedores_mas_personalizados_como_mapa 
    name            = each.key
    image           = docker_image.mi_imagen.image_id 
    ports {
        internal    = 80           
        external    = each.value.puerto_externo
        ip          = each.value.ip
    }
}
resource "docker_container" "mis_contenedores_mas_personalizados_desde_lista" { 
    count           = length(var.contenedores_mas_personalizados_como_lista)
    name            = var.contenedores_mas_personalizados_como_lista[count.index].contenedor
    image           = docker_image.mi_imagen.image_id 
    ports {
        internal    = 80           
        external    = var.contenedores_mas_personalizados_como_lista[count.index].puerto_externo
        ip          = var.contenedores_mas_personalizados_como_lista[count.index].ip
    }
}

## Recursos Condicionales a través de un bucle
resource "docker_container" "mi_balanceador" {
    count           = length(var.contenedores_personalizados) > 1 ? 1 : 0
    name            = "balanceador" 
    image           = docker_image.mi_imagen.image_id 
    ports {
        internal    = 80
        external    = 81
    }
}