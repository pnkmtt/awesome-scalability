terraform {
  required_version = ">= 0.8, < 0.10"
}

provider "aws" {
  region = "us-east-1"
}

module "kafka_brokers" {
  source = "../../../modules/services/kafka-brokers"
  cluster_name           = "${var.cluster_name}"
  broker_instance_type   = "${var.broker_instance_type}"
  key_name               = "${var.key_name}"
  number_of_brokers      = "${var.number_of_brokers}"
}

module "kafka_zookeepers" {
  source = "../../../modules/services/kafka-zookeepers"

  cluster_name                    = "${var.cluster_name}"
  zookeeper_instance_type         = "${var.zookeeper_instance_type}"
  key_name                        = "${var.key_name}"
  number_of_zookeepers            = "${var.number_of_zookeepers}"
}
