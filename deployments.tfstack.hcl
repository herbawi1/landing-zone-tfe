
deployment "prodaction"{
  inputs = {
    tfc_organization_name = var.tfc_organization_name
    tfc_hostname = "https://app.terrafrom.io"
  }
}