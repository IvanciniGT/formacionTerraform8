variable "host" {
    description = "IP o nombre del host sobre el que realizar las pruebas"
    type        = string
    nullable    = false
    
    validation {
        condition = var.host != null # TODO
        error_message = "El nombre o IP del host no es válido"
    }
}

variable "continue_on_failure"{
    description = "Debe continuar el script en caso de error en las pruebas"
    type        = bool
    default     = true
    nullable    = false
}

variable "whenDataChanges" {
    description = "Indique el dato que de cambiar, fuerza la ejecución de la prueba"
    type        = string
    nullable    = true
    default     = null
}

variable "ping" {
    type        = object({
                            initialDelay    = optional(number, 0)
                            times           = optional(number, 1)
                        })
    nullable    = true
    default     = null
    
    validation {
        condition       = var.ping == null ? true : (var.ping.initialDelay >= 0 && ceil(var.ping.initialDelay) == var.ping.initialDelay)
        error_message   = "El valor de initialDelay debe ser al menos 0"
    }
    validation {
        condition       = var.ping == null ? true : (var.ping.times >= 1 && ceil(var.ping.times) == var.ping.times)
        error_message   = "El valor de times debe ser al menos 1"
    }
}

variable "ssh_connection" {
    type        = object({
                            user       = string
                            port       = optional(number, 22)
                            password   = optional(string)
                            privateKey = optional(string)
                        })
    nullable    = true
    default     = null
    
    validation {
        condition       = var.ssh_connection == null ? true : (var.ssh_connection.port >= 1 && var.ssh_connection.port <= 64000 && ceil(var.ssh_connection.port) == var.ssh_connection.port)
        error_message   = "El puerto debe estar entre 1 y 64000"
    }
    validation {
        condition       = var.ssh_connection == null ? true : (((var.ssh_connection.password != null || var.ssh_connection.privateKey != null)
                          && ! (var.ssh_connection.password != null && var.ssh_connection.privateKey != null)))
        
        error_message   = "Debe suministrarse una contraseña o una clave privada para la conexión por ssh"
    }
}