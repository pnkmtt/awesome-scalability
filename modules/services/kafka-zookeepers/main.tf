terraform {
  required_version = ">= 0.8, < 0.10"
}

provider "aws" {
# You must set these environmental variables to use this
#$ export AWS_ACCESS_KEY_ID="anaccesskey"
#$ export AWS_SECRET_ACCESS_KEY="asecretkey"
#$ export AWS_DEFAULT_REGION="us-west-2"
}

resource "aws_instance" "zookeeper" {
 count 				= "${var.number_of_zookeepers}"
 ami                    	= "ami-c13b68ba"
 vpc_security_group_ids 	= ["${aws_security_group.kafka-zookeeper.id}"]
 availability_zone 		= "${element(var.azs, count.index)}"
 instance_type   		= "${var.zookeeper_instance_type}"
 key_name               	= "${var.key_name}"
 tags {
    Name = "${var.cluster_name}-kafka-zookeeper-${count.index}"
    Role = "kafka-zookeeper"
    Zookeeperid = "${count.index+1}"
  }
}

resource "aws_security_group" "kafka-zookeeper" {
	name	= "${var.cluster_name}-kafka-zookeeper-sg"

	ingress {
		from_port	=	"${var.zoo_keeper_client_port}"
		to_port		=	"${var.zoo_keeper_client_port}"
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
	}
	ingress {
		from_port	=	"${var.zoo_keeper_leader_port}"
		to_port		=	"${var.zoo_keeper_leader_port}"
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
	}
	ingress {
                from_port       =       "${var.zoo_keeper_leader_election_port}"
                to_port         =       "${var.zoo_keeper_leader_election_port}"
                protocol        =       "tcp"
                cidr_blocks     =       ["0.0.0.0/0"]
        }
	ingress {
		from_port	=	"22"
		to_port		=	"22"
		protocol	=	"tcp"
		cidr_blocks	=	["0.0.0.0/0"]
	}
        egress {
                from_port       =       0       
                to_port         =       0
                protocol        =       "-1"
                cidr_blocks     =       ["0.0.0.0/0"]
        }
	lifecycle {
		create_before_destroy = true
	}
}
