output "publicKeyPem" {
    value   = module.claves_ssh.publicKey.pem

}
output "privateKeyOpenSSH" {
    sensitive = true
    value   = module.claves_ssh.privateKey.openssh

}
