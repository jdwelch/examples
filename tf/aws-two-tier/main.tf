provider "aws" {
  region = "${var.region}"
}

resource "aws_elb" "webstack" {
  name = "elb-webstack"

  # The same availability zone as our instances
  availability_zones = ["${aws_instance.www.*.availability_zone}"]
  security_groups    = ["${aws_security_group.webstack-http.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # The instances are registered automatically
  instances = ["${aws_instance.www.*.id}"]
}

resource "aws_security_group" "webstack-ssh" {
  name = "allow ssh from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "webstack-http" {
  name = "allow http from anywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "www" {
  availability_zone      = "eu-west-1a"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  count                  = "${var.instance_count}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.webstack-ssh.id}", "${aws_security_group.webstack-http.id}"] # no fucking idea why security_groups isn't good enough here

  tags {
    "created_by" = "${var.tag_created_by}"
    "department" = "${var.tag_dept}"
    "lifetime" = "${var.tag_lifetime}"
    "project" = "${var.tag_project}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"

    # TODO: How does one extract this into a variable? 
    # The various options I tried did not work.
    private_key = "${file("/Users/jdwelch/.ssh/pl-ux-common.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      # This is so ugly and I love it
      # Proving the point that in fact there are three instances behind the LB
      "sudo apt-get update",

      "sudo apt-get -y install nginx",
      "echo '<h1>Coming to you live from ${self.public_dns}</h1>' > /tmp/index.nginx-debian.html",
      "sudo cp /tmp/index.nginx-debian.html  /var/www/html/index.nginx-debian.html",
    ]
  }
}

# Spit out nice friendly DNS names when you're done
output "hosts" {
  value = "${aws_instance.www.*.public_dns}"
}

output "endpoint" {
  value = "${aws_elb.webstack.dns_name}"
}
