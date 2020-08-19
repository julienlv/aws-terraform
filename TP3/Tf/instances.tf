# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "tfkeypair1" {
  key_name = "tfkeypair1"
  # généré par ssh-keygen ...
  public_key = file("../ssh-keys/id_rsa_tfkeypair1.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "sg_wordpress" {
  name   = "sg_wordpress"
  vpc_id = aws_vpc.vps_wordpress.id
  # en entrée
  # autorise ssh de partout
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise http de partout
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise icmp (ping)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_wordpress_mariadb" {
  name   = "sg_wordpress_mariadb"
  vpc_id = aws_vpc.vps_wordpress_mariadb.id
  # en entrée
  # autorise ssh de partout
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise http de partout
  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["10.42.1.0/24"]
  }
  # autorise icmp (ping)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wordpress" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "tfkeypair1"
  vpc_security_group_ids      = [aws_security_group.sg_wordpress.id]
  subnet_id                   = aws_subnet.subnet_wordpress.id
  private_ip                  = "10.42.1.10"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/instance_init1.sh")
  tags = {
    Name = "wordpress"
  }
}

resource "aws_instance" "wordpress_mariadb" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "tfkeypair1"
  vpc_security_group_ids      = [aws_vpc.vps_wordpress_mariadb.id]
  subnet_id                   = aws_subnet.subnet_wordpress.id
  private_ip                  = "10.42.1.100"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/instance_init1.sh")
  tags = {
    Name = "wordpress_mariadb"
  }
}

output "wordpress" {
  value = "${aws_instance.wordpress.*.public_ip}"
}

output "wordpress_mariadb" {
  value = "${aws_instance.wordpress_mariadb.*.public_ip}"
}
