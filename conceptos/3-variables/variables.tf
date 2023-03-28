variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor que vamos a crear"
}

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
}


