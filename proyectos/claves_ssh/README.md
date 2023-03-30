# Modulo claves_ssh

Debe permitir la generación de un par de claves ssh, que posteriormente poder usar dentro de nuestros scripts de terraform.

- Generar la clave publica
- Generar la clave privada

Pero esas claves...
1. Las exportaré a ficheros.... en que formato?
    - pem
    - openssh
   ... Y donde dejo esos ficheros? En alguna ruta que le definamos
2. Llevarlos a un output del módulo

...
Cuando genero un par de claves ssh.... hay algo configurable en ese proceso? Algoritmo y parámetros para ese algoritmo
No todos los algoritmos admiten parametros ... ni siquiera los que los admiten admiten los mismos parametros.

algorithm:  RSA, ECDSA, ED25519
ecdsa_curve : P224, P256, P384, P521. (default: P224).
rsa_bits : the size of the generated RSA key, in bits (default: 2048).

Pregunta....
Siempre que ejecute esto... debo generar un par de claves claves?
Cuando querré generarlas?
- Cuando no existan los ficheros
  Si tengo los ficheros... que debería hacer el módulo? Llevar el contenido de los ficheros al output, 
  para que esas claves estén disponibles al script
- Cuando explícitamente me pidan que las regenere

---

module "misclaves" {
    sources = "El que sea"
    
    algoritmo
    parametros del algoritmo
    
    ruta de los ficheros
    
    si se fuerza la regeneración de las claves
}

module.misclaves.publicKey
module.misclaves.privateKey (openssh, pem)



---

Script: Crear máquina en Amazon

module: mis_claves
    source = Crear claves ssh

modulo: Crar máquina en Amazon
    publicKey = module.mis_claves.publicKey.pem