variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor que vamos a crear"
    nullable        = false
    validation {
        condition       = length(regexall("^[a-zA-Z][a-zA-Z0-9_-]{5,20}$", var.nombre_contenedor)) == 1
        error_message   = "El nombre solo debe contener letras básicas, dígitos, guiones y guiones bajos. En total entre 6 y 21 caracteres. Y no comenzar por números ni guiones"
    }
}

# Solo letras básicas ascii, número y guiones bajos y medios
# ^[a-zA-Z][a-zA-Z0-9_-]{5,20}$
# Dentro de las expresiones de terraform, podemos hacer uso de FUNCIONES
# Terraform define un montón de funciones.
# https://developer.hashicorp.com/terraform/language/functions


variable "cuota_cpu" {
    type            = number
    description     = "Cuota de cpu que puede usar el contenedor (en base 1024)"
    # default         = 1024 RUINA !!!!!!
    # ESTO NO LO HACEMOS EN LA VIDA !!!!! Mala práctica!
    # Jamás en un script vamos a poner valores por defecto a las variables en este fichero
    # JAMAS ! de los JAMASES !!!!! Mala práctica!
    # En breve os cuento por qué?
    # Y más delante os contaré para que sirve esa palabra "default"
    # QUE NO ES PARA DAR VALORES POR DEFECTO A LAS VARIABLES DE UN SCRIPT !!!!
    nullable        = true # false
                    # Esto indica si a la variable se le puede asignar ADEMAS 
                    # de un valor de su tipo, el valor NULO, que es un valor especial 
    validation {
        condition       = var.cuota_cpu == null ? true : var.cuota_cpu >= 1
        error_message   = "El valor debe ser superior a 0"
    }
    validation {
        condition       = var.cuota_cpu == null ? true : var.cuota_cpu <= 4096
                            # En estas expresiones podemos usar: > >= < <= == != && ||
                            # También, en estas expresiones podemos usar el operador CONDICIONAL TERNARIO
                            #   CONDICION ? VALOR SI SE CUMPLE LA CONDICION : VALOR SI NO SE CUMPLE
                            # Mucho cuidado!!!! OJO !!!!!! IMPORTANTE !!!!!
                            # En la mayor parte de lenguajkes de programación:
                            # El operador && es el operador? AND en cortocircuito
                            # El operador || es el operador? OR en cortocircuito
                            # En Terraform, son SIN CORTOCIRCUITAR !!!!!
                          # Metemos una expresión que devolverá un valor lógico TRUE|FALSE
                          # TRUE: Todo está bien
                          # FALSE: El VALOR NO ESTA BIEN y se RECHAZA
        error_message   = "El valor debe ser inferior o igual a 4096" # Aquí pondremos un texto que se mostrará si la expresión de la condición devuelve FALSE
    }
}

variable "imagen_repo" {
    type            = string
    description     = "Repo del que sacar la imagen del contenedor"
}

variable "imagen_tag" {
    type            = string
    description     = "Tag que identifica a la imagen de contenedor"
}

variable "variables_entorno" {
    type            = map(string)
    description     = "Variables de entorno para el contenedor"
}

variable "puertos" {
    type            = list(object({
                        externo         = number
                        interno         = number
                        direccion_ip    = optional(string, "0.0.0.0")
                      }))
    description     = "Puertos a exponer en el contenedor"
    
    validation {
        
        condition = alltrue ( [ for puerto in var.puertos:
                        puerto.interno >=0 && puerto.interno <= 32000 ] )
                        
        error_message = "El puerto interno debe estar entre 1 y 32000"
        
    }
    
    
    validation {
        
        condition = alltrue ( [ for puerto in var.puertos:
                        puerto.externo >=0 && puerto.externo <= 32000 ] )
                        
        error_message = "El puerto externo debe estar entre 1 y 32000"
        
    }
    validation {
        
        condition = alltrue ( [ for puerto in var.puertos:
                                    length(regexall("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.){3}(25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)$", 
                                                    puerto.direccion_ip)) == 1
                              ] )
                        
        error_message = "La ip debe ser válida"
        
    }
}


