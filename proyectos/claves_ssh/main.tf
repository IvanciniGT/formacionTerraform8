locals {
    nombre_algoritmo                        = upper(var.algoritmo.nombre)
    
    directorio_ficheros_claves_normalizado  = ( endswith(var.directorio_ficheros_claves, "/") 
                                                ? var.directorio_ficheros_claves
                                                : "${var.directorio_ficheros_claves}/" )
    
    ruta_fichero_clave_publica_pem          = "${local.directorio_ficheros_claves_normalizado}publicKey.pem"
    ruta_fichero_clave_publica_openssh      = "${local.directorio_ficheros_claves_normalizado}publicKey.openssh"
    ruta_fichero_clave_privada_pem          = "${local.directorio_ficheros_claves_normalizado}privateKey.pem"
    ruta_fichero_clave_privada_openssh      = "${local.directorio_ficheros_claves_normalizado}privateKey.openssh"
    
    existe_fichero_clave_publica_pem        = fileexists(local.ruta_fichero_clave_publica_pem    )
    existe_fichero_clave_publica_openssh    = fileexists(local.ruta_fichero_clave_publica_openssh)
    existe_fichero_clave_privada_pem        = fileexists(local.ruta_fichero_clave_privada_pem    )
    existe_fichero_clave_privada_openssh    = fileexists(local.ruta_fichero_clave_privada_openssh)
    
    existen_los_ficheros_de_claves          = ( local.existe_fichero_clave_publica_pem      &&
                                                local.existe_fichero_clave_publica_openssh  &&
                                                local.existe_fichero_clave_privada_pem      &&
                                                local.existe_fichero_clave_privada_openssh   )
    
    contenido_fichero_clave_publica_openssh = file(local.ruta_fichero_clave_publica_openssh)
    contenido_fichero_clave_publica_pem     = file(local.ruta_fichero_clave_publica_pem)
    contenido_fichero_clave_privada_openssh = file(local.ruta_fichero_clave_privada_openssh)
    contenido_fichero_clave_privada_pem     = file(local.ruta_fichero_clave_privada_pem)
} 

resource "tls_private_key" "claves" {
    count       = local.existen_los_ficheros_de_claves && ! var.regenerar ? 0 : 1
    algorithm   = local.nombre_algoritmo
    ecdsa_curve = local.nombre_algoritmo == "ECDSA" ? upper(var.algoritmo.configuracion) : null
    rsa_bits    = local.nombre_algoritmo == "RSA"   ? var.algoritmo.configuracion        : null
    
    provisioner "local-exec" { # Para generar los ficheros de claves
        command =   <<EOT
                        mkdir -p ${local.directorio_ficheros_claves_normalizado}
                        echo "${self.private_key_openssh}"  > ${local.ruta_fichero_clave_privada_openssh}
                        echo "${self.private_key_pem}"      > ${local.ruta_fichero_clave_privada_pem}
                        echo "${self.public_key_openssh}"   > ${local.ruta_fichero_clave_publica_openssh}
                        echo "${self.public_key_pem}"       > ${local.ruta_fichero_clave_publica_pem}
                      EOT
    }
}
