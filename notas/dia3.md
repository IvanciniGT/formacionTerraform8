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
    
    
    
    
    