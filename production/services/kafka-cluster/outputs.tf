#output "ip" {
#    value = "${join(",", aws_instance.kafka-01.*.public_ip)}"
#}
