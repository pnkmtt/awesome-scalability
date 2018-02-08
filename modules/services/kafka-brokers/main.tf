terraform {
  required_version = ">= 0.8, < 0.10"
}

provider "aws" {
# You must set these environmental variables to use this plan
#$ export AWS_ACCESS_KEY_ID="anaccesskey"
#$ export AWS_SECRET_ACCESS_KEY="asecretkey"
#$ export AWS_DEFAULT_REGION="us-west-2"
}

resource "aws_instance" "brokers" {
 count                  = "${var.number_of_brokers}"
 ami                    = "ami-c13b68ba"
 vpc_security_group_ids = ["${aws_security_group.kafka-brokers.id}"]
 availability_zone      = "${element(var.azs, count.index)}"
 instance_type   	= "${var.broker_instance_type}"
 key_name               = "${var.key_name}"
 ebs_block_device {
      device_name = "/dev/sdf"
      volume_size = 500
      volume_type = "st1"
 }
 tags {
    Name = "${var.cluster_name}-kafka-broker-${count.index}"
    Role = "kafka-broker"
  }
}

resource "aws_security_group" "kafka-brokers" {
	name	= "${var.cluster_name}-kafka-brokers-sg"

	ingress {
		from_port	=	"${var.broker_server_port}"
		to_port		=	"${var.broker_server_port}"
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
	}
	ingress {
		from_port	=	"22"
		to_port		=	"22"
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
	}
	egress {
    		from_port       = 	0
    		to_port         =	0
    		protocol        = 	"-1"
    		cidr_blocks     = 	["0.0.0.0/0"]
	}
	lifecycle {
		create_before_destroy = true
	}
}
