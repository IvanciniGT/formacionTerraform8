output "ping_test"{
    value = fileexists("./ping.exit.code") ? trimspace(file("./ping.exit.code")) == "0" : false
}