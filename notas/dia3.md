# Outputs

La forma que tenemos en Terraform de exportar datos de los recursos que generamos a través de la aplciación de un script.
Y por qué son importantes? Hay otra forma de extraer info de esos recursos?
Podíamos extraer la info de .tfstate>resources.... ESTOO ES MUY MALA PRACTICA
    Ya que no tenemos control de la estructura del documento a ese nivel. Y cualquier cambio de versión (del provider) puede implicar
    que todo deje de funcionar y que necesitemos cambiar componentes externos de nuestra arquitectura (jenkins)
Para evitar esto usamos los outputs... que no era sinop una forma de completar (añadir) información al fichero .tfstate pero dentro 
del bloque .tfstate>outputs... controlando nosotros la estuctura de este trozo del documento.... y por ende evitándonos esos problemas.

Tenemos un comando que nos permite atacar a ese bloque del fichero .tfstate y extraer info:

    $ terraform output                              # Muestra info de todos los outputs en formato HCL
    $ terraform output [--json|--raw] UN_OUTPUT     # Muestra info de un output concreto
                                ^ Solo funciona con tipos simples: number, string, boolean

```tf
output "NOMBRE_DEL_OUTPUT" {
    value = # ESCRIBO UNA **EXPRESION** QUE DEVUELVA LO QUE QUIERO ALMACENAR EN EL OUTPUT
}
```

# Variables

La forma que tenemos en Terraform de parametrizar datos de los recursos que generamos a través de la aplciación de un script.

Las variables las definimos en un bloque:

```tf
variable "NOMBRE_DE_LA_VARIABLE" {
    type    = string # number | boolean | list(...)  | set(...)  | map(...)  | object({ campo = tipo 
                                                                                        campo2 = optional(tipo, default)
                                                                                     })
    descripcion = string        # Que se muestra si el dato es solicitado interactivamente
    nullable    = true | false  # Definir si la variable admite el valor null
                                # Ese valor tiene la caractarística de permitirnos NO PASAR una propiedad al provider
    validation {
        condition     = string  # Una expresión lógica... que cuando devuelve TRUE se entiende que el valor es CORRECTO / ACEPTABLE     
        error_message = string  # Si la valicación no se cumple
    }
    
    default =                   # Pero esto dijimos que ni flores
}
```

Los valores de las variables se le suministran a terraform a través de:
- Argumento en linea de comandos: --var VARIABLE=valor
- En un fichero .tfvars y suministrando la ruta de ese fichero como el argumento --var-file "RUTA"
- En un fichero .auto.tfvars... que se cargan en automático
- El default asignado en la variable
- De forma interactiva por línea de comandos

# Usos de las variables:

Por ejemplo para:
- Personalizar / parametrizar una propiedad de un recurso
- Generar bloques dinámicamente dentro de un recurso:


    resource "TIPO" "NOMBRE" {
        
        propiedad = var.nombre_variable
        
        dynamic "nombre_bloque" {
            for_each = # LISTA | SET
            iterator = nombre con el que referirme a cada elemento de la lista mientras se iterata
            content {
                Atributos/propiedades del bloque según esquema relacionado
            }
        }
    }

- Para generar recursos en BUCLE


    resource "TIPO" "NOMBRE" {
        count = # NUMERO
        # Al usar count, tenemos de regalo la variable count.index, que nos dice por cuál vamos al iterar
    }
    
    Nota: Si usamos count en un recurso... al referirnos al recurso por su nombre, como una variable: `TIPO.NOMBRE` 
    obtengo una referencia a una lista de recursos de tipo `TIPO`
    
    
---

# PROVISIONADORES

Son programas que se ejecutan asociados al ciclo de vida de un recurso:
- Creación      -- 1 evento que puedo controlar (de forma única)
- Modificación  -/
- Destrucción   -- 1 evento que puedo controlar (de forma única)

Un provisionador va asociado a 1 recurso... Se define DENTRO DEL BLOQUE DE UN RECURSO

En terraform hay 3 provisionadores que pueden usarse. SOLO 3... ANTES HABIA MAS. YA NO. 3!!!!
- local-exec    Ejecutar un comando donde está corriendo TERRAFORM
                    PUES IGUAL... poco
                        - prueba
                        - al dar de alta una máquina... me puede interesa darla de alta en el CMDB
                                                        o en un sistema de monitorizacion
- remote-exec   Ejecutar un comando en otro entorno... el que sea... no necesariamente en el recurso que estamos configurando
                Uso:
                    - Crear un usuario en el remoto \
                    - Crear unas carpetas            >  PERO ME CORTARIAN LAS UÑAS MUY CORTITAS Y ME METEN LAS MANOS EN UN BARREÑO CON ZUMO DE LIMON !!!!
                    - Instalar unos programas       /       Para eso tenemos a Ansible... and company
                    
                    HEMOS DE INTENTAR USAR ESTO LO MENOS POSIBLE
                    - Pruebas: Smoke Test
                    - Para el que venga detrás... que pueda acceder:
                        - servicio ssh corriendo...
                        - puertos abiertos...
                        - python instalado
                        - clave ssh
                        (realmente todo esto lo podría dejar realizado de antemano)... donde? 
                            IMAGEN DE MAQUINA 
                    
- file          Copiar archivos del local (Donde corre terraform) a otro sitio... el que sea
                Uso:
                    - Fichero de configuración
                    - Clave ssh

---

# Gestión del .tfstate

## Cómo organizamos y gestionamos un proyecto de terarform en la empresa?

Escribo un script de terraform... y a partir de ahí?                                            -> LO METO EN GIT
Lo ejecuto... y al hacerlo, da lugar a un fichero .tfstate ???? Y que hago con ese fichero?     -> LO METO EN GIT
        en qué repo? en el mismo que el script? 
            - puede
            - o puede que no, según me interese
        No solo como backup.... si solo quiero que esté como backup... lo copio a un sistema de backup
        En nuestro caso lo estamos subiendo a git.... que no es un sistema de backup... sino un 
            sistema de control de versiones... YA QUE QUIERO CONTROLAR LA VERSION DE ESE FICHERO... y ver cómo va evoluacionando

Pregunta.... cuántos ficheros .tfstate vamos a tener asociados a un script? 
- 1?  Y si ejecuto el mismo script contra 7 entornos, con distintas parametrizaciones? 

Terraform me da una forma de gestionar eso: Workspaces
También lo puedo gestionar por mi cuenta y riesgo... con repos de git separados para el .tfstate y el script.
Decisiones... organizativas.
Quiero que la persona que se baje el script tenga acceso a todos los .tfstate?
- Puede
- O no

---

# Tipos de pruebas:

## Tipos de Pruebas en Base al nivel de la prueba:

- Unitarias                 Prueba DE UNA UNICA CARACTERISTICA sobre un compoente AISLADO
- De integración            Prueba DE LA COMUNICACION entre 2 sistemas
- De sistema (End2End)      Pruebo el COMPORTAMIENTO del sistema en su conjunto

## Para qué sirven las pruebas?

- Para comprobar si un requerimoento se Cumple
- Identificar FALLOS    -- DEBUGGING --> Arreglar (previa identificación) los DEFECTOS
- Suministrar información en caso de que se haya producido un fallo... para que el DEBUGGING sea más sencillo

## Vocabulario en el mundo de las pruebas

- Errores       Los ERRORES los cometemos los HUMANOS cuando nos equivocamos
- Defectos      Un ERROR puede dar lugar a un DEFECTO en un sistema
- Fallos        Ese DEFECTO puede o no manifestarse en forma de un FALLO

---

Cúantas veces se va a ejecutar nuestro script de terraform para un entorno? 
1 cada vez que cambie la definición del entorno (parametrización)?
Cada hora? Tiene sentido? DEVOPS !!!!!! y que bonita es la IDEMPOTENCIA!!!!!
Si lo ejecuto cada hora, qué tengo? 
- Un sistema de Monitorización
- Junto con un doctor, que si ha habido algún problema me lo arregla... alguien torpe ha borrado el entorno


---

Qué estabamos metiendo en un script?
- Recursos
- Variables locales
- Parámetros (variables)
- Configuración de los providers
- Salidas
- Listado de providers que necesito

---

Cuando escribimos un programa... un poquito decente y complejo....
Tiramos ahi dentro de un fichero, lines y lineas y lineas de código al tuntun ???

Cuando hacemos código, ese código solemos meterlo en funciones/métodos/procedimientos... por qué?
- Reutilizarlo
- Más fácilmente interpretable 
- Más fácilmente mantenible

En terraform igual... sabeis el nombre que reciben esos procedimientos / metodos, funciones en terraform? MODULOS

función (entradas) -> Resultado

Qué estabamos metiendo en un script?
√ Recursos                              <<< LO PRINCIPAL !
√ Variables locales
√ Parámetros (variables)
- Configuración de los providers
√ Salidas
√ Listado de providers que necesito


Quiero un cluster de maquinas para instalar ES:
Subred dentro de una red
2 maquinas maestro
2 maquinas datos
2 maquinas coordinadores
balanceador delante de los coordinadores
1 maquina kibana

quiero montar un entorno elasticSearch:
    nº maquinas maestras: 2, de tipo xlarge
    nº maqiunas datos: 4 de tipo 2xlarge
    nº de maquiabns coordinadores: 2 large
    balanceador: large
    2 kibana: xlarge
    balanceador: large
    
quiero montar un entorno elasticSearch:
    nº maquinas maestras: 2, de tipo xlarge
    nº maqiunas datos: 2 de tipo 2xlarge
    nº de maquiabns coordinadores: 2 large
    balanceador: large
    1 kibana: large
    balanceador: large
    
