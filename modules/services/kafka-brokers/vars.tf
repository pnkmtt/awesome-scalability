variable "number_of_brokers" {
  description = "The number of zookeepers that are needed"
  default = 3
}

variable "broker_server_port" {
  description = "The port that zookeeper listens on"
  default = 9092
}

variable "cluster_name" {
  description = "The name of the Kafka Cluster"
}

variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "key_name" {
  description = " AWS key for region you are building within"
}

variable "broker_instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}
