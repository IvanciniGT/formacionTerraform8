variable "numero_de_contenedores" {
    type        = number
    # nullable y valiaciones
}

variable "contenedores_personalizados" {
    type        = map(number)
}

variable "contenedores_mas_personalizados_como_mapa" {
    type        = map(object({
                                puerto_externo  = number
                                ip              = optional(string,"0.0.0.0")
                             }))
}

variable "contenedores_mas_personalizados_como_lista" {
    type        = list(object({
                                contenedor      = string
                                puerto_externo  = number
                                ip              = optional(string,"0.0.0.0")
                              }))
}