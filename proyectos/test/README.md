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

Los datos que queremos tener (información)
Variables son "COMO ESTRUCTURAMOS ESA INFORMACION"



Siempre voy a querer hacer ambas pruebas?

Outputs




module "pruebas" {
    host    = "172.17.0.49"
    
    ping    = {}
    ping    = {
                    initialDelay = 10
              }
    ping    = {
                    times = 5
              }
    ping    = {
                    initialDelay = 10
                    times = 5
              }
    
    ssh_connection = {
                        user = "root"
                        password = "my-password"        # Este chequeo lo hace terraform??? Este es mio
                        privateKey = "2342340abc..."
                     }
}