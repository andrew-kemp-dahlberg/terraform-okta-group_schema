# outputs.tf
# Export information about created schema properties

output "schema_properties_created" {
  description = "List of schema property indices created for terraform-okta-departments"
  value = {
    notes                   = okta_group_schema_property.notes.index
    application_assignments = okta_group_schema_property.application_assignments.index
    mailing_lists          = okta_group_schema_property.mailing_lists.index
    push_groups            = okta_group_schema_property.push_groups.index
  }
}

output "schema_property_ids" {
  description = "Resource IDs of created schema properties"
  value = {
    notes                   = okta_group_schema_property.notes.id
    application_assignments = okta_group_schema_property.application_assignments.id
    mailing_lists          = okta_group_schema_property.mailing_lists.id
    push_groups            = okta_group_schema_property.push_groups.id
  }
}

output "ready_for_departments_module" {
  description = "Confirms that all required schema properties are created"
  value       = true
}
