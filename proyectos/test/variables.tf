variable "host" {
    type    = string
}

variable "ping" {
    type        = object({
                            initialDelay    = optional(number, 0)
                            times           = optional(number, 1)
                        })
    nullable    = true
    default     = null
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
}
