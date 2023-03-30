module "claves_ssh" {
    source = "../claves_ssh"
    algoritmo = {
                    nombre          = "ED25519"
                }
    directorio_ficheros_claves = "misclaves"
    regenerar = false
}
