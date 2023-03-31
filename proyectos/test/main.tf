# Las pruebas las debo ejecutar en un provisioner... 
# local para el ping 
# remote para el ssh... echo Eureka 

# Un provisioner de qué recurso? ya... pues venga .. un null !

locals {
    id_unico = uuid()
}

resource "null_resource" "ping_test" {
    count       = var.ping == null ? 0 : 1

    triggers    = {
                    cuando = var.whenDataChanges == null ? uuid() : var.whenDataChanges
                  }

    provisioner "local-exec" {
        command = <<EOT
                    mkdir -p /tmp/miscript/
                    sleep ${var.ping.initialDelay}
                    ping -c ${var.ping.times} ${var.host}
                    echo $? > /tmp/miscript/${local.id_unico}
                    EOT
        on_failure = continue #var.continue_on_failure ? continue : fail
    }
    
}


resource "null_resource" "ssh_connection_test" {
    count       = var.ssh_connection == null ? 0 : 1

    triggers    = {
                    cuando = var.whenDataChanges == null ? uuid() : var.whenDataChanges
                  }
    
    connection {
        host        = var.host
        type        = "ssh"
        port        = var.ssh_connection.port
        user        = var.ssh_connection.user
        password    = var.ssh_connection.password
        private_key = var.ssh_connection.privateKey
    }

    provisioner "remote-exec" {
        inline = ["echo EUREKA"]
    }
    
}

