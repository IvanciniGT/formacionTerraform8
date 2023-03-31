module "claves_ssh" {
    source = "git::https://gitlab.com/ivan.osuna.ayuste/modulo-claves-ssh-terraform/?ref=v1.1.1"
    algoritmo = {
                    nombre          = "ED25519"
                }
    directorio_ficheros_claves = "misclaves"
    regenerar = false
}
