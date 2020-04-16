resource "aws_key_pair" "default"{
  key_name = "clusterkp"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_instance" "master" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name  = "master"
  }
}

resource "aws_instance" "worker1" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name  = "worker 1"
  }
}

resource "aws_instance" "worker2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name  = "worker 2"
  }
}
resource "aws_instance" "worker3" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name  = "worker 3"
  }
}
resource "aws_instance" "worker4" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  user_data = "${file("${var.bootstrap_path}")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    Name  = "worker 4"
  }
}
resource "aws_elb" "swarm-elb" {
  name               = "docker-swarm-elb"
  subnets            = ["${var.my_public_subnets}"]


  listener {
    instance_port     = "22"
    instance_protocol = "tcp"
    lb_port           = "22"
    lb_protocol       = "tcp"
  }

  listener {
    instance_port      = "2377"
    instance_protocol  = "tcp"
    lb_port            = "2377"
    lb_protocol        = "tcp"
  }
  listener {
    instance_port      = "80"
    instance_protocol  = "http"
    lb_port            = "80"
    lb_protocol        = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "tcp:22"
    interval            = 5
  }
  security_groups             = ["${aws_security_group.default.id}"]
  instances                   = ["${aws_instance.master.id}", "${aws_instance.worker1.id}", "${aws_instance.worker2.id}", "${aws_instance.worker3.id}", "${aws_instance.worker4.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 100

  tags {
    Name = "docker-swarm-elb"
  }
}
