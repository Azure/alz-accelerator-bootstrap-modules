module "resource_names" {
  source           = "../../modules/resource_names"
  azure_location   = var.bootstrap_location
  environment_name = var.environment_name
  service_name     = var.service_name
  postfix_number   = var.postfix_number
  resource_names   = var.resource_names
}

module "files" {
  source                            = "../../modules/files"
  starter_module_folder_path        = local.starter_module_folder_path
  additional_files                  = concat(var.additional_files)
  configuration_file_path           = var.configuration_file_path
  built_in_configurartion_file_name = var.built_in_configurartion_file_name
}

module "azure" {
  source                                                    = "../../modules/azure"
  resource_group_identity_name                              = local.resource_names.resource_group_identity
  resource_group_agents_name                                = local.resource_names.resource_group_agents
  resource_group_network_name                               = local.resource_names.resource_group_network
  resource_group_state_name                                 = local.resource_names.resource_group_state
  storage_account_name                                      = local.resource_names.storage_account
  storage_container_name                                    = local.resource_names.storage_container
  azure_location                                            = var.bootstrap_location
  user_assigned_managed_identities                          = local.managed_identities
  federated_credentials                                     = local.federated_credentials
  agent_container_instances                                 = local.agent_container_instances
  agent_container_instance_image                            = var.agent_container_image
  agent_organization_url                                    = module.azure_devops.organization_url
  agent_token                                               = var.azure_devops_agents_personal_access_token
  agent_organization_environment_variable                   = var.agent_organization_environment_variable
  agent_pool_name                                           = module.azure_devops.agent_pool_name
  agent_pool_environment_variable                           = var.agent_pool_environment_variable
  agent_name_environment_variable                           = var.agent_name_environment_variable
  agent_token_environment_variable                          = var.agent_token_environment_variable
  target_subscriptions                                      = local.target_subscriptions
  root_parent_management_group_id                           = local.root_parent_management_group_id
  virtual_network_name                                      = local.resource_names.virtual_network
  virtual_network_subnet_name_container_instances           = local.resource_names.subnet_container_instances
  virtual_network_subnet_name_storage                       = local.resource_names.subnet_storage
  private_endpoint_name                                     = local.resource_names.private_endpoint
  use_private_networking                                    = var.use_private_networking
  allow_storage_access_from_my_ip                           = var.allow_storage_access_from_my_ip
  virtual_network_address_space                             = var.virtual_network_address_space
  virtual_network_subnet_address_prefix_container_instances = var.virtual_network_subnet_address_prefix_container_instances
  virtual_network_subnet_address_prefix_storage             = var.virtual_network_subnet_address_prefix_storage
  storage_account_replication_type                          = var.storage_account_replication_type
  public_ip_name                                            = local.resource_names.public_ip
  nat_gateway_name                                          = local.resource_names.nat_gateway
  
}

module "azure_devops" {
  source                                       = "../../modules/azure_devops"
  use_legacy_organization_url                  = var.azure_devops_use_organisation_legacy_url
  organization_name                            = var.azure_devops_organization_name
  create_project                               = var.azure_devops_create_project
  project_name                                 = var.azure_devops_project_name
  environments                                 = local.environments
  managed_identity_client_ids                  = module.azure.user_assigned_managed_identity_client_ids
  repository_name                              = local.resource_names.version_control_system_repository
  repository_files                             = local.repository_files
  template_repository_files                    = local.template_repository_files
  use_template_repository                      = var.use_separate_repository_for_pipeline_templates
  repository_name_templates                    = local.resource_names.version_control_system_repository_templates
  variable_group_name                          = local.resource_names.version_control_system_variable_group
  azure_tenant_id                              = data.azurerm_client_config.current.tenant_id
  azure_subscription_id                        = data.azurerm_client_config.current.subscription_id
  azure_subscription_name                      = data.azurerm_subscription.current.display_name
  pipelines                                    = local.pipelines
  backend_azure_resource_group_name            = local.resource_names.resource_group_state
  backend_azure_storage_account_name           = local.resource_names.storage_account
  backend_azure_storage_account_container_name = local.resource_names.storage_container
  approvers                                    = var.apply_approvers
  group_name                                   = local.resource_names.version_control_system_group
  agent_pool_name                              = local.resource_names.version_control_system_agent_pool
  use_self_hosted_agents                       = var.use_self_hosted_agents
}
