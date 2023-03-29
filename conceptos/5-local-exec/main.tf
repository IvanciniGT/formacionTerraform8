terraform {
    required_providers {
        docker = {
          source = "kreuzwerker/docker"
          version   = "3.0.1"
        }
        null = {
          source = "hashicorp/null"
          version = "3.2.1"
        }
    }
}

provider "null" {
}
provider "docker" { 
}

resource "docker_image" "mi_imagen" {
    name            = "nginx:latest"
}

resource "docker_container" "mi_contenedor" { 
    count           = 2
    name            = "minginx_${count.index}" 
    image           = docker_image.mi_imagen.image_id
    
    #   Potenciales problemas:
    #    - No llego a la máquina porqué la máquina no está en red
    #    - El firewall no está abierto... y tampoco llego al nginx
    #    - Nginx no ha arrancado correctamente

    # Prueba: 1? PING A LA MAQUINA 
    #    - No llego a la máquina porqué la máquina no está en red
    provisioner "local-exec" {
        command = "ping -c 1 ${self.network_data[0].ip_address}" # docker_container.mi_contenedor[count.index].network_data[0].ip_address
    }
    # Prueba: 2? 
    #   - Mirar si llego al puerto

    # Prueba: 3? 
    #   - Mirar si quien contesta en ese puerto es nginx
    # Si la prueba va mal... que conclusión saco? Nginx no ha arrancado correctamente
    provisioner "local-exec" {
        command = "curl ${self.network_data[0].ip_address}" # docker_container.mi_contenedor[count.index].network_data[0].ip_address
        # when    = destroy # Ejecutaría el provisionados solo al borrar el recurso
                            # Si no pongo esta linea, el provisionador se ejecuta al crearse o al modificarse
        on_failure = continue # Si no pongo esta linea y el provionador falla, el script se detiene
                              # Si pongo esta linea, aunque el provisionador falle, el script de terraform continua
                              # Cómo sabe terraform si el script ha fallado o no?
                              # por el codigo de respuesta (exit code) del comando que haya ejecutado.
                              # Si es 0, todo OK
                              # Si no es 0, falló

    }
    
}

# Y si en lugar de un output... generase un fichero con las IPs... 
# me podría venir bien... que jenkins pille ya ese fichero
# Incluso esto podría ser más guay que un output... por qué?
# Quién llama al output? Jenkins... y si quito terraform mañana y lo cambio por lunaform
# Si genero desde lunaform el mismo fichero.... Jenkins ni se empapa

# Quiero un fichero llamado "ips.txt", donde
# - En cada linea esté el nombre de un contenedor, un igual y su ip
# - Y así para todos los contenedores que estemos creando

locals {
    maquinas_y_sus_ips = join("\n",
                            [
                                for contenedor in docker_container.mi_contenedor: 
                                    "${contenedor.name}=${contenedor.network_data[0].ip_address}"
                            ]
                         )
}

resource "null_resource" "ejecutar_el_programa_que_genera_el_fichero_de_las_ips" {

    triggers = {
        contenido = local.maquinas_y_sus_ips
    }

    provisioner "local-exec" {
                    # HERE-DOC
        command = <<EOT
                    mkdir -p ips
                    echo "$MAQUINAS_CON_IPS" > ips/ips.txt
                    EOT
        
        interpreter = ["/bin/bash","-c"] # o python, perl, jshell, sh...
        
        environment = {
            MAQUINAS_CON_IPS = local.maquinas_y_sus_ips
        }
    }
    
}

