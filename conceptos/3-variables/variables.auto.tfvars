# Me sirve de plantilla para montar archivos de variables customizados
nombre_contenedor   = "minginx"
cuota_cpu           = 1024

imagen_repo         = "nginx"
imagen_tag          = "latest"

variables_entorno   = { 
                        VARIABLE1       = "valor1", 
                        VARIABLE2       = "valor2",
                        MIOTRAVARIABLE  = "valor3",
                        MIOTRAVARIABLE2 = "valor3",
                        MIOTRAVARIABLE3 = "valor17"
                      }
                    # POR DIOS SIEMPRE EXPLICITO !!!!!!!!!!!!!!                    
puertos             =  [
                            {
                                interno         = 80
                                externo         = 8080
                                direccion_ip    = "127.0.0.1"
                            },
                            {
                                interno         = 443
                                externo         = 8443
                            }
                       ]                
                    # POR DIOS SIEMPRE EXPLICITO !!!!!!!!!!!!!!                    
                       # ESTO FUNCIONA
                       # PERO ES UNA MIERDA GIGANTE !!!!!!