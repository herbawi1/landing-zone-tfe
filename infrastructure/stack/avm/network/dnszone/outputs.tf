# Private DNS Zone outputs (matching AVM module outputs)

output "dns_zone_id" {
    description = "The resource ID of the DNS zone."
    value = module.avm_res_network_dnszone.resource_id
}
output "name_servers" {
    description = "The list of name servers for the DNS zone."
    value = module.avm_res_network_dnszone.name_servers
}

output "number_of_records" {
    description = "The number of record sets in the DNS zone."
    value = module.avm_res_network_dnszone.number_of_record_sets
}

output "max_number_of_record_sets" {
    description = "The maximum number of record sets allowed in the DNS zone."
    value       = module.avm_res_network_dnszone.max_number_of_record_sets
}

output "a_record_outputs" {
    description = "The A record resources and their configurations."
    value       = module.avm_res_network_dnszone.a_record_outputs
}

output "aaaa_record_outputs" {
    description = "The AAAA record resources and their configurations."
    value       = module.avm_res_network_dnszone.aaaa_record_outputs
}

output "cname_record_outputs" {
    description = "The CNAME record resources and their configurations."
    value       = module.avm_res_network_dnszone.cname_record_outputs
}

output "mx_record_outputs" {
    description = "The MX record resources and their configurations."
    value       = module.avm_res_network_dnszone.mx_record_outputs
}

output "ns_record_outputs" {
    description = "The NS record resources and their configurations."
    value       = module.avm_res_network_dnszone.ns_record_outputs
}

output "ptr_record_outputs" {
    description = "The PTR record resources and their configurations."
    value       = module.avm_res_network_dnszone.ptr_record_outputs
}

output "srv_record_outputs" {
    description = "The SRV record resources and their configurations."
    value       = module.avm_res_network_dnszone.srv_record_outputs
}

output "txt_record_outputs" {
    description = "The TXT record resources and their configurations."
    value       = module.avm_res_network_dnszone.txt_record_outputs
}
