# Al respecto del source de los módulos

Terraform me permite que el código de un módulo esté en variedad de lugares:
- Local... En el source debo poner una ruta que comience por "."
- Terraform registry            


    module "vpc" {
      source  = "terraform-aws-modules/vpc/aws"
      version = "3.19.0"
    }

- Repos de git
- Buckets de S3

Más info:
https://developer.hashicorp.com/terraform/language/modules/sources