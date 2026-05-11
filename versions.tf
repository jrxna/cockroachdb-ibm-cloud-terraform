##############################################################################
# Terraform Version Constraints
##############################################################################

terraform {
  required_version = ">= 1.4.0"

  required_providers {
    # No providers required for download-only configuration
    # This is a metadata-only module
  }
}
