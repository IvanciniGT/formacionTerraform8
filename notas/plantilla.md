# Titulos de nivel 1 ###################################################
## Titulos de nivel 2 ##################################################
### Titulos de nivel 3 #################################################
#### Titulos de nivel 4 ################################################
##### Titulos de nivel 5 ###############################################
###### Titulos de nivel 6 ##############################################

Titulos de nivel 1
========================================================================

Titulos de nivel 2
------------------------------------------------------------------------

Puedo escribir textos.
Esto sería una frase del mismo párrafo.

Si quiero una frase en un párrafo diferente, basta con dejar una
linea en blanco entre ellas.

Puedo añadir listas:

## Listas desordenadas

- Item 1
- Item 2
- Item 3

+ Item 1
+ Item 2
+ Item 3 

* Item 1
* Item 2
* Item 3

No conviene mezclar en la misma lista distintos simbolos.. por aquello de no
volver gilipollas al que lo lea en texto plano.

Se usan los distinto signos para facilitar la lecura en texto plano
de listas a distintos niveles.


- Item 1
  + Item 1
  + Item 2
  + Item 3 
    * Item 1
    * Item 2
    * Item 3
- Item 2
- Item 3

## Listas ordenadas

1. Item 1
2. Item 2
3. Item 3
4. Item 4

1) Item 1
2) Item 2
3) Item 3
4) Item 4

1. Item 1
1. Item 2
1. Item 3
1. Item 4

Este no conviene por aquello de no volver
gilipollas al que lo lee en texto plano.
Pero mientras escribo un documento, y no tengo claro
cuantos puntos voy a tener me puede ser conveniente.

# Estilos de texto

- Enfasis: esta *palabra* aparece enfatizada
- Resaltada: esta **palabra** aparece enfatizada
- Resaltada y enfatizada: esta ***palabra*** aparece enfatizada

    En lugar de asteriscos se pueden poner ___guiones bajos___
    Aun que esto no está aconsejado.

- Tachado ~~esto no vale~~
- Código o palabras especiales, como `esta`

# Citas

> Esto lo dijo San Pedro

# Mucho código

```tf
resource "tls_private_key" "claves" {
    count       = local.existen_los_ficheros_de_claves && ! var.regenerar ? 0 : 1
    algorithm   = local.nombre_algoritmo
    ecdsa_curve = local.nombre_algoritmo == "ECDSA" ? upper(var.algoritmo.configuracion) : null
    rsa_bits    = local.nombre_algoritmo == "RSA"   ? var.algoritmo.configuracion        : null
    
    provisioner "local-exec" { # Para generar los ficheros de claves
        command =   <<EOT
                        mkdir -p ${local.directorio_ficheros_claves_normalizado}
                        echo "${self.private_key_openssh}"  > ${local.ruta_fichero_clave_privada_openssh}
                        echo "${self.private_key_pem}"      > ${local.ruta_fichero_clave_privada_pem}
                        echo "${self.public_key_openssh}"   > ${local.ruta_fichero_clave_publica_openssh}
                        echo "${self.public_key_pem}"       > ${local.ruta_fichero_clave_publica_pem}
                      EOT
    }
}
```

# Enlaces

Debes [ir a google](https://google.es) para ver esto.

# Imágenes 

![Tooltip](https://www.vectorlogo.zone/logos/terraformio/terraformio-ar21.png)


# Tablas

| Columna 1     | Columna 2     |
| ------------- | ------------: |
| Dato 1        | AAAA          |
| Dato 2        | `true`        |
| Dato 3        | *Pues si*     |

