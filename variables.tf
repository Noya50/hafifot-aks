variable "cluster_name" {
  description = "(Required) The name of the aks cluster"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the aks's resource group"
  type        = string
}

variable "location" {
  description = "(Required) The location associated with the aks"
  type        = string
}

variable "dns_prefix" {
  description = "(Optional) used to create a FQDN that can be used to access the aks"
  default     = ""
  type        = string
}

variable "default_node_pool_name" {
  description = "(Optional) The name of the aks's default node pool"
  type        = string
  default     = "default"
}

variable "default_node_pool_vm_size" {
  description = "(Optional) The size of the Virtual Machine of the default node pool"
  default     = "Standard_D2_v2"
  type        = string
}

variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent."
  default     = 110
  type        = number
}

variable "default_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist in the default Node Pool.."
  default     = 1
  type        = number
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the aks resource."
  type        = map(string)
  default     = {}
}

variable "acr_id" {
  description = "(Optional) Id of an acr to assign to the aks."
  default     = ""
  type        = string
}

variable "additional_node_pools" { #TODO change from set to map of object
  description = "(Optional) Values ​​for additional node pools besides the default."
  default     = null
  type = map(object({
      kubernetes_cluster_id = string
       vm_size               = string
       node_count            = number
       tags                  = map(string)
  }))
}

variable "log_analytics_workspace_id" {
  description = "(Optional) ID of the log analytics workspace to which the diagnostic setting will send the logs of this resource."
  type        = string
  default     = null
}

variable "diagnostic_setting_categories" {
  description = "(Optional) Categories of the diagnostic setting."
  type = list(string)
  default = [ "kube-apiserver", "kube-audit", "kube-audit-admin", "kube-controller-manager", "kube-scheduler", "cluster-autoscaler", "cloud-controller-manager", "guard", "csi-azuredisk-controller", "csi-azurefile-controller", "csi-snapshot-controller" ]
}

variable "identity_type" {
  description = "(Optional) the identity type of the cluster."
  type = string
  default = "SystemAssigned"
}