# Trabajando con Clouds

Crear una máquina en AWS

Terraform no me facilita en NADA el crear infra dentro de un cloud. Al contrario... me lo pone complicao!

En Amazon el servicio que ofrece la creación de servidores virtuales se llama EC2
A esos servidores virtuales en Amazon les llamamos: INSTANCIAS

AMI: Amazon Machine Image

En terraform qué vamos a meter ahí? AMI_ID: ami-00aa9d3df94c6c354 
?? Y de donde ostias saco esto??? Más vale que sepa de amazon... si no voy bien jodido!!!


Plataforma: Ubuntu
Arquitectura: x86_64
Propietario: 099720109477
Fecha de publicación: 2023-03-25
Tipo de dispositivo raíz: ebs
Virtualización: hvm
Habilitado para ENA: Sí
Modo de arranque: legacy-bios


---


Script tf  --->  terraform  ---> provider       ---> awscli -----> Servicios web de AWS
                                 hashicorp/aws
√ Terraform 
√ Descargar el provider hashicorp/aws

√ Descargar e instalar el awscli
√ Configurar el awscli

---

# Control del estado de la infraestructura

$ terraform refresh Refresca el fichero terraform.tfstate con datos del proveedor
$ terraform show    Muestra todos los recursos que tenemos, con toda su info
                    ME ahce un volcado del fichero terraform.tfstate > resources
$ terraform state list   Muestra los recursos que están siendo gestionados
De cada uno podríamos hacer un show
$ terraform state show <nombre-recurso>

---

CUIDADO !!!

Imaginad que quiero monitorizar estos recursos
O que quiero darlos de alta en el CMDB

Y monto un programa para que haga eso...
Ese programa debería leer estos datos? los que salen con estos comandos?
El problema es que estos comandos usan del fichero terraform.tfstate el bloque RESOURCES

No tengo control de la estructura de datos que ahí se genera...la dicta el provider

Imaginad que cambio de cloud!!! Esto es un trauma !
Qué pasa con mis scripts de terraform? Chungo!
Pero puede ir a más... qué pasa con todos esos programas que haya montado para:
- Dar de alta los servidores en el cmdb
- Monitorización
- ...

También dejan de funcionar.

A reescribir TODO.... Prepara billetes!
Y echo cuentas... cuánto me ahorro en el nuevo cloud? y cuánto me cuesta migrarme al nuevo cloud?
Cuanto más tiempo pase, más me cuesta... más me voy atando al cloud...
Y ESTO DEBO EVITARLO A TODA COSTA !

Lo que estamos haciendo, encubiertamente es DESARROLLAR SOFTWARE.
Y debemos acogernos a las buenas práctics que usan los desarrolladores...
Que llevan años/decadas pegandose con estas cosas... y se han comido ellos los marrones.


Datos       ||
        
RECURSOS -> ||  Terraform                   vvvv                                     vvvv
Servidores  ||  Script      -> LENGUAJE  ->Modulo -> datos -> Provider -> Salidas -> Modulo -> Salidas -> CMDB
Redes       ||                  datos


Dependen de un cloud concreto? 

No vale con que algo funcione!
Pero es pan para hoy y hambre para mañana!
