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
    name            = "minginx" 
    image           = docker_image.mi_imagen.image_id
    
    connection {
        host        = self.network_data[0].ip_address
        type        = "ssh" # winrm
        port        = 22
        user        = "root"
        password    = "root"
    }
    
    provisioner "remote-exec" {
        inline      = [ "echo Dentro del contenedor",
                        "echo EUREKA > /tmp/fichero.txt" ]    
    }
    provisioner "remote-exec" {
        script      = "./mi_script.sh"   
    }
    
    provisioner "remote-exec" {
        scripts      = [
                        "./mi_script.sh",
                        "mi_script.sh"   
                       ]
    }
   
    provisioner "file" {
        destination  = "/tmp/fichero2.txt"    
        source       = "./para_copiar.txt"
    } 
    
    provisioner "file" {
        destination  = "/tmp/fichero3.txt"    
        content      = "Soy el contenido del archivo"
                        #templatefile( "RUTA DEL FICHEOR DE TEMPLATE", {
                        #        nombre= "Ivan"
                        #        edad = var.edad
                        #        telefono = local.telefono
                        #})
                        
                       # Aqui puedo poner expresiones
                       # - templatefile... la usamos mucho en este caso
    } 
    # Este comando lo voy a ejecutar donde? 
    # Y cómo me contecto con ese "donde"?
}
