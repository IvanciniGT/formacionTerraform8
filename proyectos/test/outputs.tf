output "ping_test"{
    value = fileexists("/tmp/miscript/${local.id_unico}") ? trimspace(file("/tmp/miscript/${local.id_unico}")) == "0" : false
    depends_on = [ null_resource.ping_test ]
}