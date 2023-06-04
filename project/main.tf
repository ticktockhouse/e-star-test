module "mynetwork" {
  source = "../modules/network"

  for_each = toset(var.vpc_cidrs)

  public_subnet_newbits = 8
  private_subnet_newbits = 5
  region = "eu-central-1"
  vpc_cidr = each.key
}