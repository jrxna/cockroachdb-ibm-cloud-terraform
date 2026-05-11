##############################################################################
# Basic Example - Single Platform Download
##############################################################################

module "cockroachdb" {
  source = "../../"

  cockroachdb_version = "v26.1.4"
  target_platforms    = ["linux-amd64"]
}

output "download_url" {
  description = "Download URL for CockroachDB"
  value       = module.cockroachdb.download_urls["linux-amd64"]
}

output "checksum_url" {
  description = "SHA256 checksum URL"
  value       = module.cockroachdb.checksum_urls["linux-amd64"]
}

output "release_page" {
  description = "GitHub release page"
  value       = module.cockroachdb.github_release_url
}
