numero_de_contenedores      = 4

# Se antoja sencilla esta forma... pero... está limitada a solo un atributo
contenedores_personalizados = {
                                contenedorA =   8081
                                contenedorB =   8091
                              }

## Que pasa si al rellenar los datos, repito contenedor... ups!!
## Lo va a machacar... pero quién se entera?  YO... ya que terraform me avisa que estoy DUPLICANDO CLAVE en el MAPA !
contenedores_mas_personalizados_como_mapa = {
                                contenedorA1 =   {
                                    puerto_externo  = 8082
                                    ip              = "127.0.0.1"
                                }
                                contenedorA1 =   {
                                    puerto_externo  = 8092
                                }
                              }
# No están limitadas a un atributo
## Esta forma me parece conceptualmente más lógica, sencilla
## Esta tiene un huequito: Que pasa si al rellenar los datos, repito contenedor... ups!!
## Lo va a machacar... pero quién se entera?  NADIE !
contenedores_mas_personalizados_como_lista = [
                                {
                                    contenedor      = "contenedorA2"
                                    puerto_externo  = 8083
                                    ip              = "127.0.0.1"
                                },
                                {
                                    contenedor      = "contenedorA2"
                                    puerto_externo  = 8093
                                }
                              ]

# DESCARTADA
# No hay referencia EXPLICITA entre el nombre de un contenedor y su puerto.
# Se basa en posiciones... RUINA !
# nombres_contenedores        = [ "contenedorA", "contenedorB" ]
# puertos_a_exponer           = [ 8080,           8090         ]
# POR DIOS SIEMPRE EXPLICITO
