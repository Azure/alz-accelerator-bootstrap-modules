variable "azure_location" {
  type = string
}

variable "user_assigned_managed_identities" {
  type = map(string)
}

variable "federated_credentials" {
  type = map(object({
    user_assigned_managed_identity_key = string
    federated_credential_subject       = string
    federated_credential_issuer        = string
    federated_credential_name          = string
  }))
  default = {}
}

variable "resource_group_identity_name" {
  type = string
}

variable "resource_group_agents_name" {
  type    = string
  default = ""
}

variable "resource_group_network_name" {
  type    = string
  default = ""
}

variable "resource_group_state_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "storage_account_replication_type" {
  type    = string
  default = "GZRS"
  validation {
    condition     = var.storage_account_replication_type == "ZRS" || var.storage_account_replication_type == "GZRS" || var.storage_account_replication_type == "RAGZRS"
    error_message = "Invalid storage account replication type. Valid values are LRS, GZRS and RAGZRS."
  }
}

variable "agent_container_instances" {
  type = map(object({
    container_instance_name = string
    agent_name              = string
    cpu                     = optional(number, 4)
    memory                  = optional(number, 16)
    cpu_max                 = optional(number, 4)
    memory_max              = optional(number, 16)
    zones                   = optional(set(string), ["1"])
  }))
  default = {}
}

variable "agent_container_instance_image" {
  type    = string
  default = ""
}

variable "agent_organization_url" {
  type    = string
  default = ""
}

variable "agent_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "agent_name_environment_variable" {
  type    = string
  default = ""
}

variable "agent_pool_name" {
  type    = string
  default = ""
}

variable "agent_pool_environment_variable" {
  type    = string
  default = ""
}

variable "use_agent_pool_environment_variable" {
  type    = bool
  default = true
}

variable "agent_organization_environment_variable" {
  type    = string
  default = ""
}

variable "agent_token_environment_variable" {
  type    = string
  default = ""
}

variable "target_subscriptions" {
  type = list(string)
}

variable "root_parent_management_group_id" {
  description = "The root management group name"
  type        = string
}

variable "resource_providers" {
  type        = set(string)
  description = "The resource providers to register"
  nullable    = false
  default = [
    "Microsoft.ApiManagement",
    "Microsoft.AppPlatform",
    "Microsoft.Authorization",
    "Microsoft.Automation",
    "Microsoft.AVS",
    "Microsoft.Blueprint",
    "Microsoft.BotService",
    "Microsoft.Cache",
    "Microsoft.Cdn",
    "Microsoft.CognitiveServices",
    "Microsoft.Compute",
    "Microsoft.ContainerInstance",
    "Microsoft.ContainerRegistry",
    "Microsoft.ContainerService",
    "Microsoft.CostManagement",
    "Microsoft.CustomProviders",
    "Microsoft.Databricks",
    "Microsoft.DataLakeAnalytics",
    "Microsoft.DataLakeStore",
    "Microsoft.DataMigration",
    "Microsoft.DataProtection",
    "Microsoft.DBforMariaDB",
    "Microsoft.DBforMySQL",
    "Microsoft.DBforPostgreSQL",
    "Microsoft.DesktopVirtualization",
    "Microsoft.Devices",
    "Microsoft.DevTestLab",
    "Microsoft.DocumentDB",
    "Microsoft.EventGrid",
    "Microsoft.EventHub",
    "Microsoft.HDInsight",
    "Microsoft.HealthcareApis",
    "Microsoft.GuestConfiguration",
    "Microsoft.KeyVault",
    "Microsoft.Kusto",
    "microsoft.insights",
    "Microsoft.Logic",
    "Microsoft.MachineLearningServices",
    "Microsoft.Maintenance",
    "Microsoft.ManagedIdentity",
    "Microsoft.ManagedServices",
    "Microsoft.Management",
    "Microsoft.Maps",
    "Microsoft.MarketplaceOrdering",
    "Microsoft.Media",
    "Microsoft.MixedReality",
    "Microsoft.Network",
    "Microsoft.NotificationHubs",
    "Microsoft.OperationalInsights",
    "Microsoft.OperationsManagement",
    "Microsoft.PolicyInsights",
    "Microsoft.PowerBIDedicated",
    "Microsoft.Relay",
    "Microsoft.RecoveryServices",
    "Microsoft.Resources",
    "Microsoft.Search",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
    "Microsoft.ServiceBus",
    "Microsoft.ServiceFabric",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.StreamAnalytics",
    "Microsoft.TimeSeriesInsights",
    "Microsoft.Web"
  ]
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
  default     = ""
}

variable "virtual_network_address_space" {
  type        = string
  description = "The address space for the virtual network"
  default     = "10.0.0.0/24"
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public ip"
  default     = ""
}

variable "nat_gateway_name" {
  type        = string
  description = "The name of the nat gateway"
  default     = ""
}

variable "virtual_network_subnet_name_container_instances" {
  type        = string
  description = "Name of the virtual network subnet"
  default     = ""
}

variable "virtual_network_subnet_name_storage" {
  type        = string
  description = "Name of the virtual network subnet"
  default     = ""
}

variable "virtual_network_subnet_address_prefix_container_instances" {
  type        = string
  description = "Address prefix for the virtual network subnet"
  default     = "10.0.0.0/26"
}

variable "virtual_network_subnet_address_prefix_storage" {
  type        = string
  description = "Address prefix for the virtual network subnet"
  default     = "10.0.0.64/26"
}

variable "storage_account_private_endpoint_name" {
  type    = string
  default = ""
}

variable "use_private_networking" {
  description = "Controls whether to use private networking for the runner to storage account and runner to container registry communication"
  type        = bool
  default     = true
}

variable "allow_storage_access_from_my_ip" {
  type    = bool
  default = false
}

variable "container_registry_name" {
  type        = string
  description = "The name of the container registry"
  default     = ""
}

variable "container_registry_private_endpoint_name" {
  type    = string
  default = ""
}

variable "container_registry_dockerfile_repository_folder_url" {
  type        = string
  description = "The branch and folder of the repository containing the Dockerfile"
  default     = ""
}

variable "container_registry_dockerfile_name" {
  type        = string
  description = "The dockerfile to build"
  default     = "dockerfile"
}

variable "container_registry_dockerfile_repository_access_token" {
  type    = string
  default = ""
}

variable "container_registry_image_name" {
  type        = string
  description = "The name of the image to build"
  default     = ""
}

variable "container_registry_image_tag" {
  type        = string
  description = "The pattern for the image tag"
  default     = "{{.Run.ID}}"
}

variable "use_self_hosted_agents" {
  type    = bool
  default = true
}

variable "container_instance_managed_identity_name" {
  type    = string
  default = ""
}