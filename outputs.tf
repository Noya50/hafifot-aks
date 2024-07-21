output "name" {
  value       = azurerm_kubernetes_cluster.this.name
  description = "The name of the aks."
}

output "id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "The id of the aks."
}

output "location" {
  value       = azurerm_kubernetes_cluster.this.location
  description = "The location of the aks."
}

output "resource_group_name" {
  value       = azurerm_kubernetes_cluster.this.resource_group_name
  description = "The name of the resource group of the aks."
}
