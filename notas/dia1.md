
# Terraform?

Es una herramienta de software que fabrica una empresa llamada: HASHICORP (VAULT, VAGRANT) que nos ofrece:
- Un lenguaje (propio) DECLARATIVO, llamado HCL (HashiCorp Language) -> Para escribir Scripts (de automatización)
- Un intérprete de lina de comandos con el que ejecutar tareas sobre los SCRIPTS que escribirmos en ese lenguaje

## Uso:

Para gestionar (adquirir, liberar, mantener) recursos que nos ofrecen proveedores:

| Recursos              | Proveedores               |
| --------------------- | ------------------------- |
| Máquina virtual       | Cloud                     |
| Snapshot              | VMWare                    |
| Despliegue            | Kubernetes                |
| Clase ssh             | Generador de claves ssh   |
| Una entrada en un DNS | Servidor de DNS           |

El principal uso: Gestionar infraestructuras dentro de CLOUDS

# CLOUD

- Proveedor de servicios (IT)
- Conjunto de servicios que una empresa (IT) ofrece a través de internet:
  - Los servicios se ofrecen de forma automatizada y desantedida (por su parte, por parte del cloud). No hay ninguna persona detrás.
  - Modelo de pago por USO

## Clouds importantes
 
- AWS < Amazon
- Azure < Microsoft
- Google Cloud Platform < Google
- .....
- IBM Cloud < IBM (es malo?)

## Tipos de servicios

- Infraestructura (IaaS) - Almacenamiento, Servidores, Redes
- Plataforma      (PaaS) - Bases de datos, Active Directory(LDAP), cluster de Kubernetes/Openshift, Cluster de Spark
- Software        (SaaS) - Office365, Cloud9, APIs(recocimiento de voz, traducción, text2Speech)

## Son importantes los clouds?

- Es una forma de subcontratar trabajos de Administración/operación IT
- Flexibilidad (ahorro de costes)

### Qué características debe tener un entorno de producción?

- Alta disponibilidad: REDUNDANCIA
  Tratar de garantizar:
  - La NO PERDIDA DE INFORMACION (datos)
  - la disponibilidad de un servicio
- Escalabilidad
  Capacidad de ajustar la infra a las necesidades de cada momento. Y hoy en día esas necesidades son MUY VARIABLES!


    App X: WEB TELEPI
        Hora n             0 usuarios
        Hora n+1     1000000 usuarios
        Hora n+2        2000 usuarios
        Hora n+3     5000000 usuarios

Para automatizar el trabajo de MI LADO es cuando usamos TERRAFORM.

---

# DEV--->OPS

Cultura / movimiento en pro de la AUTOMATIZACION y MONITORIZACION

Quiero automatizar TODO el trabajo.

- Quizás el trabajo es solamente crear una infra en un cloud.
  Para eso podemos usar TERRAFORM

Si monto unos SCRIPTS DE TERRAFORM COJONUDOS !! Ya lo tengo todo automatizado? NO
Me falta automatizar la ejecución de esos scripts ! A ESTO NOS AYUDAN HERRAMIENTAS COMO Jenkins, Gitlab CI/CD, Github Actions, Travis, Bamboo, TeamCity
Esas herramiemtas adicionalmente las usamos para ORQUESTAR TRABAJOS. 

Terraform es solo un eslabón más en una CADENA MUCHO MAS LARGA (dev->ops)

## Segunda acepción?

Usamos esta palabra también para referirnos a un PERFIL
- Desarrolladores
- Testers
- Adminsitradores de sistemas
- Arquitectos
- Devops

Cuál es la responsabilidad de un devops?
- Al tio/a que sabe de terraform, ansible, puppet le llamamos DEVOPS!
  - Realmente ese es el devops? Este es el administrador de sistemas de TODA LA VIDA, que ahora AUTOMATIZA lo que antes hacia a manubrio
    Mediante el uso de terraform, puppet, chef, ansible, kubernetes
- El desarrollador que antes hacia un huevo de cosas a mano:
  - Compilar y empaquetar su proyecto
  - Gestionar las dependencias de su proyecto
  Hoy en día han automatizado un huevo: Maven, Gradle, SBT, NPM, 
- Los testers antes hacian pruebas a mano:
  Hoy en dia las automatizan: postman, Sopaui, ReadyAPI, Karate, Selenium, Appium, jmeter, load runner

El devops es un perfil nuevo que me hace falta: implementar la cultura de automatización del ciclo de vida desde el desarrollo hasta la
operación de un sistema, pasando por todas las fases intermedias: JENKINS, ...
----

Lo vamos a hacer con TERRAFORM SON SCRIPTS de automatización... y el lenguaje DECLARATIVO no nos ayuda mucho a entender ESTE CONCEPTO.

SCRIPTS??? Programa (que realiza una secuencia de instrucciones/comandos/órdenes)

Nuestro trabajo ya no es ADMINISTRAR UNA INFRA, OPERAR UNA INFRA, NI GESTIONAR UNA INFRA:
Nuestro trabajo es Desarrollar Programas que hagan por nosotros TODAS ESAS TAREAS.

Como tal, hemos de seguir las buenas prácticas que los desarrolladores llevan creando y usando décadas.

---

# Lenguaje declarativo: HCL

Lenguaje:
- Sintaxis                              Las reglas con las que podemos juntar esos tokens
- Alfabeto/morfología/Ortografía        Con los tokens que podemos usar en el lenguaje
- Semantica                             Significados

Declarativo:

Habitualmente que tipo de lenguajes usamos en el mundo de la informatica? IMPERATIVOS (print, if, else, for, while)
Nos gustan los lenguajes imperativos? Bueno... llevamos usándolos décadas. 
PERL, BASH, PYTHON, PS1

Pero nos hemos dado cuenta que hay lenguajes que nos permiten expresar las cosas de una forma MUCHO MAS COMODA -> DECLARATIVOS.

Hoy en día, todas las herramienats que se usan y se han puesto de moda, lo hacen por usar lenguajes DECLARATIVOS:
- Terraform
- Ansible
- Kubernetes
- Docker/compose

## Ejemplo de lenguaje imperativo:

Computer ! Change directory (cd)
Make directory (mkdir)                                                          < Lenguaje imperativo
                                                                                  Me basta con mirar el verbo: to make -> Tiempo imperativo
Felipe, pon una silla debajo de la ventana                                      < Lenguaje imperativo
                                                                                  Me basta con mirar el verbo: poner -> Tiempo imperativo
Los lenguajes imperativos son muy naturales a la hora de usarse. Nos sale solo.

Queremos automatizar trabajos contra AWS. A parte de Terraform, hay alguna otra herramienta?   awscli
Queremos automatizar trabajos contra AZURE. A parte de Terraform, hay alguna otra herramienta? az

Si tengo awscli... az... y similares para el resto de clouds? Por qué usamos Terraform? que lo hace un tercero?
Porque usa un lenguaje DECLARATIVO.

## Problema grande del lenguaje imperativo

En qué me centro al hablar usando un lenguaje imperativo? Me centro en lo que el otro tiene que hacer
Perdiendo de vista el objetivo... y eso nos da problemas.


    IF ya hay una silla debajo de la ventana
        Felipe, QUIETO !!! No haga na'
    IF hay algo debajo de la ventana,
        Felipe, quita ese algo!
    IF no hay sillas
        Felipe, vete al Ikea a comprar una silla !
    Felipe, pon una silla debajo de la ventana


    OBJETIVO? Disponer de una silla debajo de la ventana

## Lenguajes declarativos

Se centran en el objetivo, en mi necesidad, delagando la responsabilidad de plantear las tareas que son necesarias para conseguir ese objetivo al otro.


    Felipe! Debajo de la ventana ha de haber una silla!                         < Le estoy dando una orden?Esto no es imperaativo. No hay una "orden" aqui
    

Así entendido... cuando queremos disponer de una infra en un cloud, que le voy a dar a Felipe (computadora/terraform)?

Le voy a datar el listado de recursos que necesito en el cloud: CATALOGO DE RECURSOS
Si lo pienso... en ese "codigo" que le doy a Felipe, lo que meto es ese listado(catalogo) de recursos.
He definido mi infraestructura en un Código. -> Infraestructura como código

## Terraform vale para todos?

Si hago un script que monte un servidor en AWS... con unas características (core, ram, volumes...)
Ese script me sirve para ejecutarlo también en AZURE? NO

La lógica nos sigue haciendo falta... pero esa la pone TERRAFORM? De hecho no... la pone lo que denominamos un PROVIDER en terraform.

---

# Scripts de Terraform

Es una carpeta que contrendrá un conjunto de archivos con extensión .tf, escritos en lenguaje HCL.
Qué nombre tendrán esos archivos? A terraform le da igual!!!!
Hay ciertos CONVENIOS que se usan (IMPORTANTE RESPETAR LOS CONVENIOS):
- main
- versions
- variables
- outputs

En esos archivos vamos a declarar bloques de código. Esos bloques pueden ser de distinta naturaleza:
- terraform         LUNES
                    Declarar la versión de terraform que quiero usar
                    Declarar los providers que quiero usar y su versión
- provider          LUNES
                    Declarar la configuración que queremos usr para un determinado provider
- resource          LUNES / MARTES
                    Declarar un recurso que gestionaremos a través de un provider
    - provisioner   Declarar provisionadores asociados a un recurso: MIERCOLES
                    Básicamente son programas/tareas que quiero ejecutar asociadas al ciclo de vida de un recurso
- output            MARTES <<<<<<<<<<<<<<<<
                    Declarar datos que debemos ser capaces de extraer de los recursos (normalmente)
- variable          MARTES / MIERCOLES      *** Con diferencia es lo más complejo que tiene terraform ***
                    Declarar parámetros de ejecución de nuestro script
- locals            JUEVES
                    Declarar variables de uso interno de nuestro script
- module            JUEVES
---------- ^ Y hasta aquí no vamos a tocar NI UN CLOUD!
- data              VIERNES
- Y YA !

# Interprete de comandos de terraform

Ese comando (terraform) me permite ejecutar ORDENES sobre scripts de terraform. Aquí tenemos lenguaje imperativo:

- init              Descargar los providers que vamos a usar
                    Descargar .... otra cosita... de la que ya hablaremos
- validate          Valida un script (sintacticamente)
- refresh           Sincroniza el estado ACTUAL REAL del proveedor en Terraform (Me actualiza el fichero .tfstate)
- plan              Planificar las tareas necesarias para conseguir el ESTADO DESEADO partiendo del ESTADO ACTUAL que terraform conoce
- apply             Ejecutar esas tareas:
                    - Crear infra? Puede
                    - Borrar infra? Puede
                    - Modificar infra? Puede
- destroy           Destruir *TODOS* LOS RECURSOS que se hayan creado y terraform conoce

En la operativa del día a día... cuantas veces vamos a ejecutar un "destroy"? 1, cuando acabe el proyecto!
En el día a día: Lo que hacemos son APPLYs

En el curso, vamos a hacer MUCHOS destroys.... ESA NO ES LA FORMA DE TRABAJAR CON TERRAFORM.
Esta guay para el curso y no ir generando basura entre ejemplos. Pero NO EN LA REALIDAD

# PROVIDER: 
                                                                                    IBM cloud
terraform/azure                                                                     Azure
terraform/aws                                                                       AWS
Es un programa que tiene la lógica necesaria para gestionar recursos a través de un EXTERNO (proveedor de recursos = CLOUD, Servidor de DNS, Kubernetes)
Ese programa está desarrollado de tal forma que:
- Permita solicitarle trabajo mediante un lenguaje DECLARATIVO
- Terraform debe saber COMUNICARSE con ese programa.

Para AWS, tendremos un provider
Para AZURE, tendremos otro provider
...

Nuestro trabajo:

Script para crear/gestionar  ->  Intérprete de Terraform    ->  Provider        -> intermediario    -> CLOUD
unos recursos en AMAZON

    SCRIPT DE TERRAFORM             APPLY                       terraform/aws       awscli              aws


---

Nosotros querremos llegar a un ESTADO DESEADO, partiendo de un ESTADO ACTUAL... un poco más complejo

En terraform tenemos 3 estados!

    ESTADO DESEADO          >          ESTADO ACTUAL que TERRAFORM CONOCE     <      >    ESTADO ACTUAL REAL
        script                                  .tfstate                                  proveedor de recursos externo

# Ciclo de vida de un recurso

Los recursos, desde el punto de vista de terraform pueden ser:
- Creados
- Eliminados
- Modificados

Cada recurso tendrá una determinada configuración deseada.

Si el recurso no existe, e informo de que debe existir, terraform GESTIONA SU CREACION (LO CREARA)
Si el recurso existe, e informo de que el recurso no debe existir, terraform GESTIONA SU ELIMINACION (LO ELIMINARÁ)
Si el recurso existe, pero con una configuración REAL (al menos lo que conozca terraform) distinta a la DESEADA, terraform...
    - GESTIONA SU MODIFICACION (LO MODIFICARÁ)
        Pero... no todo cambio de configuración puede realizarse directamente... en ocasiones será necesario:
    - GESTIONA SU ELIMINACION (LO ELIMINARÁ) y GESTIONA SU CREACION (LO CREARA)
    De qué dependerá esto? Del tipo de recurso, del tipo de cambio y del proveedor externo
    
    Terraform simplemente identificará un CAMBIO en la configuración. Si hay cambio, solicita al provider la aplicación de ese cambio.
    El provider determina si el cambio puede realizarse tal cual, o si es necesario la recreación del recurso(lo que implica su eliminación y nueva creación)

---

Por el hecho de tener un lenguaje DECLARATIVO, vamos a tener lo que llamamos IDEMPOTENCIA

IDEMPOTENCIA????
Da igual el estado INICIAL siempre llego al mismo estado FINAL al ejecutar ese algo

Terraform ofrece IDEMPOTENCIA a nivel de script ! En este sentido... terraform me lo pone un poco más facil que Ansible...
    Aunque también la puedo cagar!!!!!! < provisioners

OJO! Ansible ofrece IDEMPOTENCIA? NO. La mayoría (ni siquiera todos) los modulos de Ansible ofrecen idempotencia.
    Pero Ansible NO GARANTIZA IDEMPÔTENCIA A NIVEL DE SCRIPT (Playbook)... esa me la como YO como desarrollador, si la quiero!

---

En lugar de crear servidores en AWS o en AZURE, vamos a crear un concepto EQUIVALENTE. 
Un sitio donde ejecutar procesos? contenedores

Los contenedores y el proveedor de contenedores de terraform son muy sencillitos.

# Contenedor

Entorno aislado dentro de un SO Linux donde ejecuar procesos.

Para crear un contenedor, partimos de una Imagen de contenedor.

Entorno aislado:
- Los contenedores tienen su propia configuración de red... y por ende, su propia IP(s)... en una red virtual que genera docker
- También tienen sus propias variables de entorno
- Su propio sistema de archivos
- Pueden tener limitación de acceso a los recursos HW del host

Los usamos como una alternativa a las máquinas virtuales. Ya que me ofren también en disponer de un entorno AISLADO dende ejecutar programas,
pero son mucho más ligeros que las máquinas virtuales:
- Las máquinas virtuales ejecutan su propio Sistema operativo
- En cambio los contenedores reutilizan el kernel del SO del host. De hecho no es posible instalar ni ejecutar un kernel de SO en un contenedor.
  Se usa el del host!

# Imagen de contenedor

Fichero comprimido (.tar) que dentro tiene una estructura de carpetas compatible con POSIX (no necesariamente pero si habitualmente)
que dentro de esa estructura de carpetas incluye unos programas ya instalados y preconfigurados de antemano.

Las imagenes de contenedor las sacamos de un REGISTRO DE REPOSITORIOS DE IMAGENES DE CONTENEDOR:
- Docker hub

Para gestionar y trabajar con contenedores usamos gestores de contenedores:
- *Docker*
- containerD
- Crio
- Podman


3.0.2

2.20.0
     ^ MICRO
  ^ MINOR
^ MAYOR


Cuando sube MICRO? Arreglo de bugs (FIX)
Cuando sube MINOR? Nueva funcionalidad
Cuando sube MAYOR? Cambios que implican NO RETROCOMPATIBILIDAD

---

Cuando configuramos recursos, hemos de establecer sus propiedades de configuración.
En la docu del recurso, dentro del provider concreto, me informarán (SCHEMA) de las propiedaes que puedo / debo configurar

Cada propiedad tendrá un TIPO DE DATOS

String      = Cadenas de texto...       que en HCL ponemos entre comillas
Boolean     = Valores lógicos:          true / false
Number      = Números                   7       9.7
List(...)   = Listas ordenadas          [ ... ]
                List(Number)            [1, 2, 3, 7]
                List(String)            ["texto1","texto2"]
Set(...)    = Listas desordenadas
                Set(Number)             [1, 2, 3, 7]
                Set(String)             ["texto1","texto2"]
Map(...)    = Conjuntos de clave/valor  { "clave1" = "valor1", "clave2"= "valor2"}
                diccionario
                map
                array asociativo
                
Podremos acceder a los items de una lista de 2 formas:
- Iterando entre ellos: DameOtro! <- bucle(for-each)
- A través de su posición en la lista
 
Podremos acceder a los items de un set de 1 forma:
- Iterando entre ellos: DameOtro! <- bucle(for-each)

Hasta aquí es facil.... siempre:
    propiedad = VALOR

Y AQUI SE JODE TODO !

Block. Estos tienen su propia sintaxis... y los usamos un huevo !!!!
    propiedad_de_tipo_bloque {
        propiedad1 = "texto"
        propiedad2 = true
        propiedad3 = [1,2,3,4]
        propiedad4_de_tipo_bloque {
            subpropiedad1 = {
                clave1 = "valor1",
                clave2 = true
            }
        }
    }
    
Los bloques tienen lo que llamos un ESQUEMA ANIDADO, que permite definir SUBPROPIEDADES
LOS BLOQUE NO LLEVAN IGUAL !!!!!!!

Aquí hay otra cosa... Normalmente no voy a encontrar propiedades de tipo BLOQUE (BLOCK)
Va a ser más complejo. Las encontrasé de tipo BLOCK SET o BLOCK LIST