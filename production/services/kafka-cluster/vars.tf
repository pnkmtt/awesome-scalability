variable "key_name" {
  description = " AWS key for region you are building within"
  default = "nova"
}

variable "cluster_name" {
  description = "The name of the Kafka Cluster"
  default = "kafka-01"
}

variable "broker_instance_type" {
  description = "Broker node instance type"
  default          = "t2.micro"
}

variable "zookeeper_instance_type" {
  description = "ZooKeeper node instance type"
  default          = "t2.micro"
}

variable "number_of_zookeepers" {
  description = "The number of zookeepers that are needed"
  default = 3
}

variable "number_of_brokers" {
  description = "The number of brokers that are needed"
  default = 6
}
