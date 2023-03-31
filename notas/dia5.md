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
