# ==========================================
# AZURE MONITOR WORKSPACE EXISTANT
# ==========================================

data "azurerm_monitor_workspace" "main" {
  name                = var.azure_monitor_workspace_name
  resource_group_name = var.resource_group_name
}

# ==========================================
# ACTION GROUP
# ==========================================

resource "azurerm_monitor_action_group" "main" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  email_receiver {
    name                    = "email-alerts"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Team        = var.team
    }
  )
}

# ==========================================
# ALERTE KQL — ERREURS HTTP
# ==========================================

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "http_errors" {
  name                = var.kql_alert_name
  resource_group_name = var.resource_group_name
  location            = var.location

  scopes = [
    var.log_analytics_workspace_id
  ]

  description          = "Alerte déclenchée lorsque le nombre de requêtes HTTP en erreur dépasse le seuil défini."
  severity             = 2
  enabled              = true
  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"

  criteria {
    query = <<-KQL
      AppRequests
      | where Success == false
      | summarize ErrorCount = count()
    KQL

    time_aggregation_method = "Count"
    threshold               = var.http_error_threshold
    operator                = "GreaterThanOrEqual"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [
      azurerm_monitor_action_group.main.id
    ]
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Team        = var.team
    }
  )
}

# ==========================================
# ALERTE PROMETHEUS
# ==========================================

resource "azurerm_monitor_alert_prometheus_rule_group" "custom_metric" {
  name                = "prometheus-alert-stray-cats-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  scopes = [
    data.azurerm_monitor_workspace.main.id
  ]

  description        = "Alerte Prometheus déclenchée lorsqu'une cible supervisée devient indisponible."
  interval           = "PT1M"
  rule_group_enabled = true

  rule {
    alert      = "PrometheusTargetDown"
    expression = "up == 0"
    for        = "PT5M"
    severity   = 2
    enabled    = true

    annotations = {
      description = "Une cible Prometheus est indisponible depuis au moins cinq minutes."
      summary     = "Cible Prometheus indisponible"
    }

    labels = {
      environment = var.environment
      team        = var.team
    }

    action {
      action_group_id = azurerm_monitor_action_group.main.id
    }

    alert_resolution {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Team        = var.team
    }
  )
}