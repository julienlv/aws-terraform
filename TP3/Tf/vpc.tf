# Changer le nom vpc_example pour un déploiement précis
# Adapter le réseau
resource "aws_vpc" "vpc_example" {
  cidr_block = "10.42.1.0/24" # RFC 1918, réseau privé
}

# Changer le nom subnet_example pour un déploiement précis
# Adapter le réseau (voire en ajouter)
resource "aws_subnet" "subnet_example" {
  vpc_id                  = aws_vpc.vpc_example.id # cf. ressource ci-dessus
  cidr_block              = "10.42.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.vpc_example.id
}

resource "aws_route" "wan_access" {
  route_table_id         = aws_vpc.vpc_example.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

