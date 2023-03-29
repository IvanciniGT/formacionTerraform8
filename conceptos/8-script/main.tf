
module "nginx" {
    source              = "../7-modulo"
    nombre_contenedor   = "minginx"
    imagen_repo         = "nginx"
    puertos             = [
                            {
                                interno = 80
                                externo = var.puerto_nginx
                            }
                          ]
}
module "apache" {
    source              = "../7-modulo"
    nombre_contenedor   = "miapache"
    imagen_repo         = "httpd"
    puertos             = [
                            {
                                interno = 80
                                externo = var.puerto_apache
                            }
                          ]
}
