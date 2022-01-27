# Azure Policy: Deny Subnet Size

## Description

Azure custom Policy definition to deny specific VNET subnet size (e.g /24)

## Background/Use case

Used in scenraio's where you want to deny the creation of Subnet who are equal to VNET Addressspace.
Example: Landing-zone VNETs have all /24 address spaces and you don't want to the creation of /24 subnets.
If this policy is assigned with the parameter set to /24:

- Creation of /24 subnet is denied
- Creation of smaller subnets is allowed
- Works both for:
  - Creating new VNET's
  - Updating/adding Subnet on existing VNET's

> **_NOTE:_** With this policy the creation of bigger subnets (e.g. /23 or /22 etc.) isn't possible; Subnets cannot be bigger than VNET address space.

## Deploy

Deploy Policy to Management Group or Subscription level.
Assign policy and provide Subnet (e.g. /16 or /22 or /24 etc.) to parameter.

| Description | Bicep Template |
|---|---|
| Deploy to Azure Management Group| [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPieterbasNagengast%2FAzurePolicy-DenySubnetSize%2Fmain%2FSubnetPolicy-MgmtGrp.json)|
| Deploy to Azure Subscription | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPieterbasNagengast%2FAzurePolicy-DenySubnetSize%2Fmain%2FSubnetPolicy-Sub.json)|
