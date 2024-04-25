locals {
  webapp_zip_file_path = "${path.root}/../src/web-app.zip"
}

resource "azurerm_service_plan" "spoke" {
  name                = "asp-${var.team_name}-dev-${var.location_short}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "spoke" {
  name                                           = "app-${var.team_name}-dev-${var.location_short}"
  location                                       = azurerm_resource_group.spoke.location
  resource_group_name                            = azurerm_resource_group.spoke.name
  service_plan_id                                = azurerm_service_plan.spoke.id
  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
    TEAM_NAME                      = var.team_name
    LOCATION                       = var.location_short
  }

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  identity {
    type = "SystemAssigned"
  }


}

# This is a workaround for zip_deploy_file not authorized error. 
# DON'T DO THIS IN PRODUCTION!
# TODO: Open github issue and link
resource "null_resource" "zip_deploy" {
  triggers = {
    file_hash = filemd5(local.webapp_zip_file_path)
  }

  provisioner "local-exec" {
    command = "az webapp deploy --name ${azurerm_linux_web_app.spoke.name} --resource-group ${azurerm_resource_group.spoke.name} --src-path ${local.webapp_zip_file_path} --type zip"
  }
}

resource "azurerm_role_assignment" "web_app_to_spoke_storage" {
  scope                = azurerm_storage_account.spoke.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.spoke.identity[0].principal_id
}

resource "azurerm_role_assignment" "web_app_to_hub_storage" {
  scope                = var.hub_storage_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.spoke.identity[0].principal_id
}
