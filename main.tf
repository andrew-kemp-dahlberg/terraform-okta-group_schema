
# main.tf
# Creates the exact schema properties required by terraform-okta-departments module

# Notes field - used for group documentation and Terraform management tracking
resource "okta_group_schema_property" "notes" {
  index       = "notes"
  title       = "Notes"
  type        = "string"
  description = "Notes and documentation about the group (includes Terraform management notices)"
  master      = "OKTA"
  permissions = "READ_WRITE"
  scope       = "SELF"
  required    = false
  max_length  = 4096
}

# Application assignments - tracks which applications are assigned to the group
resource "okta_group_schema_property" "application_assignments" {
  index       = "applicationAssignments"
  title       = "Application Assignments"
  type        = "array"
  array_type  = "string"
  description = "List of application groups assigned to this department"
  master      = "OKTA"
  permissions = "READ_WRITE"
  scope       = "SELF"
  required    = false
}

# Mailing lists - tracks associated email distribution lists
resource "okta_group_schema_property" "mailing_lists" {
  index       = "mailingLists"
  title       = "Mailing Lists"
  type        = "array"
  array_type  = "string"
  description = "Mailing list groups associated with this department"
  master      = "OKTA"
  permissions = "READ_WRITE"
  scope       = "SELF"
  required    = false
}

# Push groups - for Okta Verify push notifications
resource "okta_group_schema_property" "push_groups" {
  index       = "pushGroups"
  title       = "Push Groups"
  type        = "array"
  array_type  = "string"
  description = "Okta Verify push notification groups for this department"
  master      = "OKTA"
  permissions = "READ_WRITE"
  scope       = "SELF"
  required    = false
}

# Assignment profile - for role-based app assignments
resource "okta_group_schema_property" "assignment_profile" {
  index       = "assignmentProfile"
  title       = "Assignment Profile"
  type        = "string"
  description = "Profile data for application role assignments"
  master      = "OKTA"
  permissions = "READ_WRITE"
  scope       = "SELF"
  required    = false
  max_length  = 4096  # Or whatever limit makes sense for your JSON profiles
}