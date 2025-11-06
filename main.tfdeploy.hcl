
deployment "prodaction"{
  inputs = {
    tenant_id = "45bfcffa-0d57-4346-b803-9d86e3f32b29"
    subscription_id = "91fad5bc-2183-4850-8223-6dd60b088062"

    client_id = "KNx8Q~iVaGnH5XXHakpqv4o0X-sFD5m7CLmTUbEd"
    client_secret = "a1641afe-bad8-4e85-9a09-f7606da51214"

    customer_name = "herbawi"
    project_name = "landingzone"
    project_region = "eastus"
    project_env = "prd"

    default_tags = {
      mangedBy = "terraform"
    }
  }
}