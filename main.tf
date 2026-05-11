##############################################################################
# CockroachDB Download Configuration
##############################################################################

locals {
  # CockroachDB download base URL
  download_base_url = "https://binaries.cockroachdb.com"

  # Platform-specific binary names
  platform_binaries = {
    "linux-amd64"  = "cockroach-${var.cockroachdb_version}.linux-amd64.tgz"
    "linux-arm64"  = "cockroach-${var.cockroachdb_version}.linux-arm64.tgz"
    "darwin-amd64" = "cockroach-${var.cockroachdb_version}.darwin-10.9-amd64.tgz"
    "windows-amd64" = "cockroach-${var.cockroachdb_version}.windows-6.2-amd64.zip"
  }

  # Construct download URLs for selected platforms
  download_urls = {
    for platform in var.target_platforms :
    platform => "${local.download_base_url}/${local.platform_binaries[platform]}"
  }
}

# This is a download-only configuration
# No resources are provisioned
# URLs and metadata are provided as outputs for consumption
