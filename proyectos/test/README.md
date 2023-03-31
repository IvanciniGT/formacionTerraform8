Imaginad que montamos una infra
En esa infra, puede ser que necesitemos hacer algunas pruebas
Si he montado una máquina, que tenga acceso a esa máquina:
- ping
- que el puerto esté abierto
- que el servicio responda
- que un proceso esté corriendo
- que me pueda conectar por ssh

Me podría interesar tener un módulo que me permita este tipo de pruebas, ya prediseñadas.
- ping
- que me pueda conectar por ssh

Variables
- host
- numero repeticiones de ping
- initdelay
- puerto ssh
- usuario
- password / clavePrivada
- Cuando?
    - Siempre que ejecute el script?
        - Cuando haya cambio en la infra
        - Aunque no haya cambio en la infra

Los datos que queremos tener (información)
Variables son "COMO ESTRUCTURAMOS ESA INFORMACION"



Siempre voy a querer hacer ambas pruebas?

Outputs

    
          "aws_instance"
resource "docker_container" "servidor"{
    ....
}




module "pruebas" {
    host            = docker_container.servidor.ip
    ping            = {}
    ssh_connection  = {
        user = "root"
        password ="root"
    }
}
---

CLOUD

quiero una máquina en una vpc

variable vpc_name

recurso vpc
    vpc_name

recurso subnet
    vpc.vpc_name
    # depends_on vpc.  UNA PRACTICA HORRIBLE EN TERRAFORM

recurso reglas firewall red
    vpc_name

recurso maquina
    vpc_name
