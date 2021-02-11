resource "helm_nonprod" "wordpress" {
  name       = var.name_helm

  repository = "https://charts.bitnami.com/bitnami"
  chart      = var.name_chart

  dynamic "set" {
    for_each = [for s in set: {
      name   = s.name
      chart  = s.chart
    }]
    content {
      name_helm  = set.value.name
      name_chart = set.value.chart
    }
  }
}