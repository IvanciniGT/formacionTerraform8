# Terraform

- Lenguaje HCL, que es un lenguaje declarativo
- Intérprete, con el que ejecutar comandos sobre los scrips que montamos usando HCL.

 # Script de terraform
 
 Una carpeta que tiene dentro archivos .tf
 
 En esos archivos definimos bloques:
 - terraform    Declarar providers que se van a utilizar
 - provider     Declarar la configuración de un provider
 - resource     Declarar un recurso y su configuración
    provisioners    Y sus provisionadores...
 - output       Declarar datos que vamos a exportar
 - variable     Declarar parámetros del script
 - locals       Declarar "variables" de uso interno
 - module
 - data
 
Sobre esos scripts, con ayuda del comando terraform podemos ejecutar acciones tales como:
- init          Descargar el provider
                y algo más???
- validate      Validar la SINTAXIS del script
- refresh       Actualiza el fichero .tfstate con datos del provider
- plan          Determinar la secuencia de acciones para llegar al estado deseado
- apply         Ejecuta las acciones que hayan sido planificadas
                - Se creen nuevos recursos
                - Se modifiquen recursos
                - Se destruyan recursos
- destroy       Desmantela la infra

Decíamos que en Terraform manejamos:

<-------------------------------plan-------------------------------------->
                                        <------------------------------refresh-------------------------->
ESTADO DESEADO                          ESTADO ACTAL CONOCIDO POR TERRAFORM     ESTADO ACTUAL DE LA INFRA
El que defino en el script                  Se almacena en un fichero               En el proveedor de 
+ con la parametrización concreta           llamado .tfstate                        recursos externo
+ que esté utilizando

A la hora de configurar Recursos (resource) dentro del script de terraform, establecemos sus propiedades.
Algunas serán obligatorias... otras opcionales.
Todas tiene un tipo de datos:
- string
- number
- boolean
- list(...)     Listas ordenadas -> Puedo acceder a un elemento de la lista por su posición
- set(...)      Lista desordenada -> Solo puedo iterar sobre los elementos del set
- map(...)      Conjunto de clave-valor

Teníamos también los BLOCKs, que se encontraban en forma de Block Lists o Block Sets.
Tienen una sintaxis diferente (no llevan igual) y tienen un esquema anidado, donde se definen propiedades de segundo nivel.

# Provider

Un programa que tiene la lógica para gestionar los recursos de un proveedor de recursos externo.
Terraform habla con este programa.

# Algoritmo de hash

SHA, MD5

Función que dada una entrada (Secuencia de bytes) genera una salida (secuencia de bytes)
De forma que:
- La misma entrada siempre genera la misma salida
- Desde la salida puedo regenerar la entrada? NO
- Dos entradas pueden generar la misma salida= SI, claro! 
  Esto no está garantizado... Y es lo que en los algoritmos de hash llamamos colisiones
  Habitualmente los algoritmos que usamos tienen un ratio de colisiones muy bajo.
  SHA-256 > SHA-512 > SHA-2048

Letra del DNI = Un algoritmo de Hash
Cómo se calcula? Se divide el número entre 23. Nos quedamos con el RESTO

        2300001 | 23
                ----------- 
              1   100000
              ^ Resto de la div entera : Está entre 0 y 22
              
El ministerio ofrece una tabla donde a cada uno de esos restos le asigna un número
1/23= 4%

---

JENKINS-------------------
|   ^                    |
|   ip                   ip
v   |                    v
TERRAFORM             ANSIBLE

crear un servidor     planchar el servidor


Puedo pasar info de terraform a ansible... No lo haría en la puñetera vida. 
QUIERO COMPONENTES DESACOPLADOS !

No podría yo hacer en Jenkins? CLARO QUE PODRÍA ... PERO NUNCA LO HARIA
cmd: 'grep "ip_address" terraform.tfstate | head -n1'