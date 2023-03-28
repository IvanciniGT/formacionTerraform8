
output "direcciones_ip" {
    #value = docker_container.mi_contenedor.ip_address
    value = [ for contenedor in docker_container.mi_contenedor:
             contenedor.network_data[0].ip_address} ]
}
output "direcciones_ip_variante" {
    #value = docker_container.mi_contenedor.ip_address
    value = docker_container.mi_contenedor[*].network_data[0].ip_address
}
output "direcciones_ip_como_texto" {
    #value = docker_container.mi_contenedor.ip_address
    value = join(",",[ for contenedor in docker_container.mi_contenedor:
             contenedor.network_data[0].ip_address ])
}
