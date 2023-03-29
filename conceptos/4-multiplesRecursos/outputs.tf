
output "direcciones_ip" {
    value = [ for contenedor in docker_container.mis_contenedores:
             contenedor.network_data[0].ip_address} ]
}
output "direcciones_ip_variante" {
    value = docker_container.mis_contenedores[*].network_data[0].ip_address
}
output "direcciones_ip_como_texto" {
    value = join(",",[ for contenedor in docker_container.mis_contenedores:
             contenedor.network_data[0].ip_address ])
}
