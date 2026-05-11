##############################################################################
# Multi-Platform Example
##############################################################################

module "cockroachdb" {
  source = "../../"

  cockroachdb_version = "v24.3.3"
  target_platforms = [
    "linux-amd64",
    "linux-arm64",
    "darwin-amd64",
    "windows-amd64"
  ]

  tags = {
    environment = "production"
    application = "cockroachdb"
    managed_by  = "terraform"
  }
}

output "all_download_urls" {
  description = "All download URLs by platform"
  value       = module.cockroachdb.download_urls
}

output "all_checksums" {
  description = "All checksum URLs by platform"
  value       = module.cockroachdb.checksum_urls
}

output "download_commands" {
  description = "Download commands for each platform"
  value       = module.cockroachdb.download_commands
}
