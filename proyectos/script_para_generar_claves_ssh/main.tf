module "claves_ssh" {
    source = "../claves_ssh"
    algoritmo = {
                    nombre          = "RSA"
                    configuracion   = 4096
                }
    directorio_ficheros_claves = "./claves"
    regenerar = false
}
