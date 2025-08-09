# Okta Group Schema Setup for terraform-okta-departments

Simple root module that creates the required Okta group schema properties for the `terraform-okta-departments` module to function.

## Purpose

The `terraform-okta-departments` module requires specific custom schema properties to exist on Okta groups. This root module creates those properties once, allowing the departments module to work without errors.

## Schema Properties Created

| Property | Type | Purpose |
|----------|------|---------|
| `notes` | string | Group documentation and Terraform management notices |
| `applicationAssignments` | array[string] | Application groups assigned to departments |
| `mailingLists` | array[string] | Email distribution lists for departments |
| `pushGroups` | array[string] | Okta Verify push notification groups |

## Prerequisites

- Okta OAuth 2.0 application with:
  - Client Credentials grant type
  - Scopes: `okta.schemas.manage`, `okta.schemas.read`
  - Private key for authentication

## Deployment with Spacelift

### 1. Create Spacelift Stacks

Create separate stacks for each environment:
- `okta-group-schema-dev`
- `okta-group-schema-staging`  
- `okta-group-schema-prod`

All stacks point to the **same repository and root directory** - we stay DRY!

### 2. Configure Stack Environment Variables

For each stack, set these environment variables:

```bash
# Okta Configuration
TF_VAR_okta_org_name=your-company        # Use dev/staging/prod org as needed
TF_VAR_okta_base_url=oktapreview.com     # or okta.com for prod
TF_VAR_okta_client_id=<encrypted>
TF_VAR_okta_private_key_id=<encrypted>
TF_VAR_okta_private_key=<encrypted>

# Backend Configuration (S3)
TF_BACKEND_bucket=terraform-state-okta-dev  # Different per environment
TF_BACKEND_key=group-schema/terraform.tfstate
TF_BACKEND_region=us-east-1
TF_BACKEND_encrypt=true
TF_BACKEND_dynamodb_table=terraform-locks-okta-dev
```

### 3. Deploy

1. **Dev Stack**: Deploy and test
2. **Staging Stack**: Validate against staging Okta
3. **Prod Stack**: Deploy to production with approval

## Local Development

```bash
# Clone repository
git clone <repo>
cd terraform-okta-group-schema-setup

# Create tfvars (don't commit!)
cp terraform.tfvars.example terraform.tfvars
# Edit with your values

# Initialize
terraform init

# Plan
terraform plan

# Apply (creates schema properties)
terraform apply
```

## Validation

After deployment, verify the schema properties exist:

```bash
terraform output schema_properties_created
```

Expected output:
```
{
  notes = "notes"
  application_assignments = "applicationAssignments"
  mailing_lists = "mailingLists"
  push_groups = "pushGroups"
}
```

## Using with terraform-okta-departments

Once deployed, the `terraform-okta-departments` module can use these schema properties:

```hcl
module "engineering" {
  source = "git::https://github.com/yourorg/terraform-okta-departments.git"
  
  department_name         = "Engineering"
  mailing_list_names     = ["eng-all@company.com"]
  application_group_names = ["GitHub-Users", "AWS-Engineers"]
  notes                  = "Engineering department managed by Terraform"
  
  # ... other configuration
}
```

## Troubleshooting

### Schema Property Already Exists

If properties already exist, import them:

```bash
terraform import okta_group_schema_property.notes notes
terraform import okta_group_schema_property.application_assignments applicationAssignments
terraform import okta_group_schema_property.mailing_lists mailingLists
terraform import okta_group_schema_property.push_groups pushGroups
```

### Permission Errors

Ensure your OAuth app has:
- `okta.schemas.manage` scope
- `okta.schemas.read` scope
- Super Admin or appropriate admin role

## Notes

- This module is idempotent - safe to run multiple times
- Schema properties are org-wide in Okta
- Only needs to be deployed once per Okta organization
- The same code is used for all environments (DRY principle)

