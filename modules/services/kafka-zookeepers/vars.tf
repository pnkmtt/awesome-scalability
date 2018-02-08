variable "number_of_zookeepers" {
  description = "The number of zookeepers that are needed"
  default = 3
}

variable "zoo_keeper_client_port" {
  description = "The port that zookeeper listens on"
  default = 2181
}
variable "zoo_keeper_leader_port" {
  description = "The port that zookeeper listens on"
  default = 2888
}
variable "zoo_keeper_leader_election_port" {
  description = "The port that zookeeper listens on"
  default = 3888
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

variable "zookeeper_instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}
