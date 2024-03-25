# az-landingzone
This is to create landing zones in Azure


HUB and SPOKE Topology (EU) Westeurope:-



Repos - 3
=======



1. Apply governance and control es-repo.
2. Hub - repo : FedID : hub subscription : connectivity
3. Spoke - repo : FedID : spoke subscription : any lz under landingzones



========================================================================



HUB :-
===========
1. Create VNET in HUB subscription (should not overlap with spoke) - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network.html
1 subnet in here



2. Create VNET in Spoke subscription.
2 subnets



3. Create an Azure VM in spoke. / Test able to connect to different URL's



4. Create Azure Firewall.



5. Create vnet peering.

Terraform Registry