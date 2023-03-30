# Modulo claves_ssh

Permite la generación de un par de claves ssh, que posteriormente poder usar dentro de nuestros scripts de terraform.
También permite exportar/importar claves desde ficheros, en formato pem y openssh.

## Algortimos soportados para las claves

| Algoritmo | Parametrización                 |
| --------- | :-----------------------------: |
| `RSA`     | Número de bits                  |
| `ECDSA`   | `P224`, `P256`, `P384`, `P521`  |
| `ED25519` | Ninguna                         |

## Opciones de configuración:

### algoritmo

El algoritmo y su configuración para generar las claves ssh

```tf
algoritmo = {
                    nombre          = "RSA"
                    configuracion   = 4096
              }
```
### directorio_ficheros_claves

Indica el directorio donde se generarán las claves.

```tf
directorio_ficheros_claves = "./claves"
```

### regenerar

Indica si regeneraremos las claves aún existiendo los correspondientes ficheros en el directorio suministrado en 
la propiedad: `directorio_ficheros_claves`

```tf
regenerar = true
```

## Outputs del módulo:

### publicKey

```tf
publicKey.pem       # Devuelve la clave pública en formato pem
publicKey.openssh   # Devuelve la clave pública en formato openssh
```

### privateKey

```tf
privateKey.pem       # Devuelve la clave privada en formato pem
privateKey.openssh   # Devuelve la clave privada en formato openssh
```


## Ejemplo completo de uso:

```tf
module "claves_ssh" {
    source = "DONDE OSTIAS ESTE ESTO"
    algoritmo = {
                    nombre          = "RSA"
                    configuracion   = 4096
                }
    directorio_ficheros_claves = "./claves"
    regenerar = false
}
```

## Cualquier duda contactar con 

<ivan.osuna.ayuste@gmail.com>