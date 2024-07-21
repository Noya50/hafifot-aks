resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool_name
    vm_size    = var.default_node_pool_vm_size
    node_count = 1
    max_pods   = var.default_node_pool_max_pods
  }

  identity { 
    type = var.identity_type
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags, default_node_pool]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = var.additional_node_pools != null ? var.additional_node_pools : tomap({})
  name                  = each.key
  kubernetes_cluster_id = each.value.kubernetes_cluster_id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count

  tags = each.value.tags

}

module "diagnostic_setting" {
  source = "git::https://github.com/Noya50/hafifot-diagnosticSetting.git"

  name                       = "${azurerm_kubernetes_cluster.this.name}-diagnostic-setting"
  target_resource_id         = azurerm_kubernetes_cluster.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_setting_categories = var.diagnostic_setting_categories
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "azurerm_role_assignment" "acr_push" {
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPush"
  scope                = var.acr_id
}
