output "publicKey" {
 
    value   = ( length(tls_private_key.claves) == 1
                ? {
                    openssh = tls_private_key.claves[0].public_key_openssh
                    pem     = tls_private_key.claves[0].public_key_pem
                  }
                : {
                    openssh = local.contenido_fichero_clave_publica_openssh
                    pem     = local.contenido_fichero_clave_publica_pem
                  } )

}
output "privateKey" {
    sensitive = true

    value   = ( length(tls_private_key.claves) == 1
                ? {
                    openssh = tls_private_key.claves[0].private_key_openssh
                    pem     = tls_private_key.claves[0].private_key_pem
                  }
                : {
                    openssh = local.contenido_fichero_clave_privada_openssh
                    pem     = local.contenido_fichero_clave_privada_pem
                  } )

}

#module.misclaves.publicKey.pem
#module.misclaves.publicKey.openssh
#module.misclaves.privateKey.pem
#module.misclaves.privateKey.openssh
