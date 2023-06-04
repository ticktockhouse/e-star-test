# E-Star Technical test
# Overview

This repository contains sufficient Terraform code to bring up the networking infrastructure described in the requirements of the technical test.

The resource creation and so on is contained in a module, `module/network/`, which is called with relevant input values in the accompanying directory, `projects/`

Subnets are automatically calculated, using the `cidrsubnet()` function. The important values here are `public_subnet_newbits` and `private_subnet_newbits`. In this contexxt "newbits" refers to the size of the subnets in CIDR notation. So, for a VPC with a /16 CIDR block, to create a subnet of /24 would require a newbits value of 8. See [here](https://developer.hashicorp.com/terraform/language/functions/cidrsubnet) for more details.


The module accepts a list of VPC CIDR blocks, in case multiple VPCs need to be created using the code.

# Usage

To use the module, `cd` to the `project/` directory. Set the `vpc_cidrs` variable - it must be a list of CIDR blocks, even if the list only contains one item. The requirement of this exercise requires:
```
vpc_cidrs = [
  "10.0.0.0/16"
]
```
and run:

```
# terraform init
```
This will initialise Terraform by downloading the AWS provider and the necessary module.
```
# terraform plan 
```
This compares the state file (if any) with information from the AWS API to decide if infrastructure needs creating or destroying.
```
# terraform apply
```
This applies the plan and creates or destroys infrastructure as required

# Caveats

- The supplied values for `vpc_cidrs` must be a list of valid IPv4 CIDR blocks and the `toset()` function must be used to feed in the values using a `for_each` loop

- The newbits value must be compatible with the VPC's CIDR block. So a VPC with a /24 CIDR block cannot have a newbits value greater than 8 for its subnets.