
output "direcciones_ip" {
    value = [ for contenedor in docker_container.mis_contenedores:
             contenedor.network_data[0].ip_address ]
}
output "direcciones_ip_variante" {
    value = docker_container.mis_contenedores[*].network_data[0].ip_address
}
output "direcciones_ip_como_texto" {
    value = join(",",[ for contenedor in docker_container.mis_contenedores:
             contenedor.network_data[0].ip_address ])
}
output "direcciones_ips_mis_contenedores_personalizados"{
    value   = join("\n",[ for nombre, contenedor in docker_container.mis_contenedores_personalizados:
             "${nombre} ansible_host=${contenedor.network_data[0].ip_address}" ])
}
output "direccion_ip_de_acceso_al_sistema"{
    value   = (
                length(docker_container.mi_balanceador) == 1 ?
                docker_container.mi_balanceador[0].network_data[0].ip_address :
                values(docker_container.mis_contenedores_personalizados)[0].network_data[0].ip_address
              )
                #docker_container.mis_contenedores_personalizados[
                #    keys(docker_container.mis_contenedores_personalizados)[0]
                #].network_data[0].ip_address
                
                # La del balanceador SI existe ... 
                # y si no la del contenedor que haya en mis_contenedores_personalizados
}