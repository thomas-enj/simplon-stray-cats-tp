# ==========================================
# ACTION GROUP
# Canal de notification des alertes
# ==========================================

resource "azurerm_monitor_action_group" "main" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  email_receiver {
    name                    = "email-equipe"
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
# ALERTE APM KQL
# Détection des erreurs HTTP
# ==========================================

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "http_errors" {
  name                = var.kql_alert_name
  resource_group_name = var.resource_group_name
  location            = var.location

  scopes = [
    var.log_analytics_workspace_id
  ]

  description          = "Alerte déclenchée lorsque trop de requêtes HTTP échouent"
  severity             = var.kql_alert_severity
  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"
  enabled              = true

  criteria {
    query = <<-KQL
      AppRequests
      | where Success == false
      | summarize ErrorCount = count()
    KQL

    time_aggregation_method = "Count"
    threshold               = var.http_error_threshold
    operator                = "GreaterThan"
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
# ALERTE PROMETHEUS / PROMQL
# Activée seulement si Managed Prometheus existe
# ==========================================

resource "azurerm_monitor_alert_prometheus_rule_group" "custom_metric" {
  count = var.enable_prometheus_alert ? 1 : 0

  name                = var.prometheus_rule_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  scopes       = [var.azure_monitor_workspace_id]
  cluster_name = var.cluster_name
  interval     = "PT5M"
  enabled      = true

  rule {
    alert      = "CustomMetricThresholdExceeded"
    expression = var.promql_expression
    for        = "PT5M"
    severity   = var.prometheus_alert_severity
    enabled    = true

    action {
      action_group_id = azurerm_monitor_action_group.main.id
    }

    annotations = {
      description = "La métrique Prometheus personnalisée a dépassé le seuil défini."
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