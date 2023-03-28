
output "direccion_ip" {
    #value = docker_container.mi_contenedor.ip_address
    value = docker_container.mi_contenedor.network_data[0].ip_address
}

# Esos valores los puedo obtener posteriormente mediante:
# $ terraform output

# Para pedirle un output concreto uso:
# $ terraform output NOMBRE

# Esto devuelve formato HCL... NO... no es estandar

# Para transmitier datos entre sistemas prefiero una sintaxis más aceptada 
# Como json
# $ terraform output --json NOMBRE
# Como el dato en crudo
# $ terraform output --raw NOMBRE
