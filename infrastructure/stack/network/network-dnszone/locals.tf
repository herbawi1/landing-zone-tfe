locals {
  resources_names_prefix = format(
    "%s-%s-%s-%s",
    trimspace(coalesce(var.customer_name, "")),
    trimspace(coalesce(var.project_name, "")),
    trimspace(coalesce(var.project_env, "")),
    trimspace(coalesce(var.project_region, "")),
  )
  # Merge user-provided tags with module-specific tags (user-provided overrides defaults)
  tags = merge(
    var.default_tags,
    var.tags, {}
  )

  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
  name =coalesce(var.name, null)
  
# a_records
a_records = merge({}, var.a_records)
# aaaa_records
aaaa_records = merge({}, var.aaaa_records)
# cname_records
cname_records = merge({}, var.cname_records)
# mx_records
mx_records = merge({}, var.mx_records)
# ptr_records
ptr_records = merge({}, var.ptr_records)
# srv_records
srv_records = merge({}, var.srv_records)
# txt_records
txt_records = merge({}, var.txt_records)
# caa_records
caa_records = merge({}, var.caa_records)
# ns_records
ns_records = merge({}, var.ns_records)

}
