variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor que vamos a crear"
    nullable        = false
    validation {
        condition       = length(regexall("^[a-zA-Z][a-zA-Z0-9_-]{5,20}$", var.nombre_contenedor)) == 1
        error_message   = "El nombre solo debe contener letras básicas, dígitos, guiones y guiones bajos. En total entre 6 y 21 caracteres. Y no comenzar por números ni guiones"
    }
}

variable "cuota_cpu" {
    type            = number
    description     = "Cuota de cpu que puede usar el contenedor (en base 1024)"
    # ES PARA DAR VALORES POR DEFECTO A LAS VARIABLES DE UN MODULO !!!!
    default         = null
    nullable        = true 
    validation {
        condition       = var.cuota_cpu == null ? true : var.cuota_cpu >= 1
        error_message   = "El valor debe ser superior a 0"
    }
    validation {
        condition       = var.cuota_cpu == null ? true : var.cuota_cpu <= 4096
        error_message   = "El valor debe ser inferior o igual a 4096"
    }
}

variable "imagen_repo" {
    type            = string
    description     = "Repo del que sacar la imagen del contenedor"
}

variable "imagen_tag" {
    type            = string
    description     = "Tag que identifica a la imagen de contenedor"
    default         = "latest"
}

variable "variables_entorno" {
    type            = map(string)
    description     = "Variables de entorno para el contenedor"
    default         = {}
}

variable "puertos" {
    type            = list(object({
                        externo         = number
                        interno         = number
                        direccion_ip    = optional(string, "0.0.0.0")
                      }))
    description     = "Puertos a exponer en el contenedor"
    default         = []
    
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


