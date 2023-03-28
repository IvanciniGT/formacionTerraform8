# En HCL, que es el lenguaje con el que escribimos estos archivos, podemos poner comentarios.
# Usamos el cuadradito, igual que en la bash o python.


#############################################################################################
terraform {
    # Declaramos los proveedores que vamos a usar
    # Lo podría tener yo en un repo de git mio....
    # Habitualmente NO ME DECICO A MONTAR PROVEEDORES
    # Voy a usar proveedores que otros hayan hecho.
    # Y que distribuirán normalmente a través del TERRAFORM REGISTRY
    required_providers {
        docker = {
          source = "kreuzwerker/docker"
          version   = "3.0.1"
        }
    }
}

#############################################################################################
#provider "NOMBRE_DE_UN_PROVIDER" { # Dar la configuración de UN proveedor. Tendremos tantas como proveedores (providers)
#}

provider "docker" { 
}

#############################################################################################
resource "docker_image" "mi_imagen" { # Declarar un recurso y dar su configuración. Tendremos tantas como recursos necesitemos.
                                                 # El tipo de recurso será: NOMBRE_DEL_PROVEEDOR_QUE_PROPORCIONA_EL_RECURSO seguido de un guión bajo
                                                 # Y el tipo de recurso
                                                 # El nombre del recurso nos sirve como IDENTIFICADOR del recurso dentro del script.
                                                 # El nombre del recurso lo usamos como una VARIABLE en programación!
    name            = "nginx:latest"
} # < apply : Descargar la imagen de contenedor = docker image pull

resource "docker_container" "mi_contenedor" { 
    name            = "minginx" 
    image           = docker_image.mi_imagen.image_id # "sha256:ac232364af842735579e922641ae2f67d5b8ea97df33a207c5ea05f60c63a92d" # Este es el valor que debe ir aquí!
                                                # Al hacer esto consigo: 
                                                # - El valor real... que se haya descargado... y no un valor que he tomado en un momento dado y que posteriormente puede no seguir sirviendo
                                                # - Consigo generar una dependencia entre recursos, que influirá en el grafo que terraform calcula.
    env             = [ "VARIABLE1=valor1" ]
    ports {
        internal    = 80            # http
        external    = 8080
        ip          = "127.0.0.1"
    }
    ports {
        internal    = 443            # https
        external    = 8443
    }
} # < apply : Crear el contenedor : docker container create

# Sabeis si esto va a funcionar? Pues yo tampoco !
# Sabeis por que no se si va a funcionar?
# Porque no se en que orden se van a crear los recursos.
# Y para poder crear el contenedor, que tiene que haber ocurrido? Que ya se haya descargado la imagen (en relidad no... pero eso es algo prticular de los contenedores)

# Pregunta. 
# Le he dicho yo a terraform, que el SEGUNDO recurso DEPENDE DEL PRIMERO? NO
# Pero Iván... hemos escrito la imagen antes del contenedor en el fichero!!!
# Iván : A Terraform se la trae al fresco el orden de escritura!

# Terraform genera un grafo de dependencias entre recursos. 
# Ese grafo hasta le pondemos pintar en PNG o en SVG... y lo haremos en el curso.
# Y usa ese grafo para determinar el orden en el que los recursos deben ser creados o eliminados.
# Le hemos dado a terraform alguna pista de qué recurso depende de quién ? NO 
# Terraform podría lanar los 2 recursos en paralelo.
# Y entoncs esto no funcionará.

# Si lo ejecutamos ahora va a afuncionar. Sabeis por qué? Porque ya lo tengo descargado. Y no hay problema

# Como le damos instrucciones a Terraform en este sentido?
# OPCION GUAY: CReando relaciones entre ellos en las propiedades
# LA OPCION CUTRE y PROHIBIDA BAJO PENA DE CORTAR LOS DEDITOS !!!!!!!!!!
# TOTALMENTE PROHIBIDA que ni si quiera os voy a contar por ahora.