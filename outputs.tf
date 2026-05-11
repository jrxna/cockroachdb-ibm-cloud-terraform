##############################################################################
# Outputs
##############################################################################

output "cockroachdb_version" {
  description = "The CockroachDB version being downloaded"
  value       = var.cockroachdb_version
}

output "download_urls" {
  description = "Download URLs for CockroachDB binaries by platform"
  value       = local.download_urls
}

output "checksum_urls" {
  description = "SHA256 checksum URLs for verifying downloads"
  value = {
    for platform, url in local.download_urls :
    platform => "${url}.sha256sum"
  }
}

output "github_release_url" {
  description = "GitHub release page URL for this version"
  value       = "https://github.com/cockroachdb/cockroach/releases/tag/${var.cockroachdb_version}"
}

output "documentation_url" {
  description = "CockroachDB documentation URL for this version"
  value       = "https://www.cockroachlabs.com/docs/stable/"
}

output "supported_platforms" {
  description = "List of platforms configured for download"
  value       = var.target_platforms
}

output "download_commands" {
  description = "Sample download commands for each platform"
  value = {
    for platform, url in local.download_urls :
    platform => "curl -o cockroach-${var.cockroachdb_version}.${endswith(url, ".zip") ? "zip" : "tgz"} ${url}"
  }
}
