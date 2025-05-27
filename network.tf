# Use existing VPC resources (cannot create new ones due to folder restrictions)

# Reference existing network
data "yandex_vpc_network" "existing_network" {
  network_id = "enpes1pbrsaal6s83ehh"
}

# Reference existing subnet in ru-central1-a
data "yandex_vpc_subnet" "existing_subnet" {
  subnet_id = "e9bojadgs2bq45374f1g"  # ru-central1-a subnet
}

# Reference existing security group
data "yandex_vpc_security_group" "existing_sg" {
  security_group_id = "enpcq1hanif0c6ne64ru"
}
