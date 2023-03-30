variable "algoritmo" {
    type    =   object({
                            nombre          = string
                            configuracion   = optional(string)
                        })
    default = {
                    nombre          = "RSA"
                    configuracion   = 2048
              }
    nullable            = false
    description         = "Algoritmo que debe usarse para la generación de la clave ssh, junto con su cofiguración"
    validation {
        condition       = contains(["RSA", "ECDSA", "ED25519"], upper(var.algoritmo.nombre))
        error_message   = "El algoritmo debe ser uno entre: RSA, ECDSA, ED25519"
    }
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "ED25519" 
                                ? true 
                                : var.algoritmo.configuracion == null )
        error_message   = "Para el algoritmo ED25519 no debe suministrar una configuración"
    }
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "ECDSA" 
                                ? true 
                                : contains(["P224", "P256", "P384", "P521"], upper(var.algoritmo.configuracion) )
        error_message   = "Para el algoritmo ECDSA debe suministrar uno de estos valors para la configuración: P224, P256, P384, P521"
    }
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "RSA" 
                                ? true 
                                : ! can(tonumber(var.algoritmo.configuracion)) 
                                    ? false
                                    : tonumber(var.algoritmo.configuracion) >= 1024
                                      && tonumber(var.algoritmo.configuracion) <= 4096
                                      && ceil(tonumber(var.algoritmo.configuracion)) == tonumber(var.algoritmo.configuracion) # Me aseguro que sea entero
                          )
        
        error_message   = "Para el algoritmo RSA debe suministrar como configuración un número entero mayor que 1024 y menor que 4096 (longitud en bits de la clave)"
    }
    
}

variable "directorio_ficheros_claves" {
    type            = string 
    description     = "Directorio de donde se leen / donde se guardan las claves ssh generadas"
    default         = "./claves"
    nullable        = false
    
    validation {
        condition     = length(regexall("^((([.]{1,2}[\\/])|[\\/])?([a-zA-Z0-9_-]+[\\/]?))|[.]+$", var.directorio_claves )) == 1
        error_message = "Debe introducir una ruta local"
    }
}


variable "regenerar" {
    description = "Indica si deben generarse nuevas claves ssh, aun existiendo unas claves en el directorio suministrado"
    type        = boolean 
    default     = false
    nullable    = false
}

