##############################################################################
# Input Variables
##############################################################################

variable "cockroachdb_version" {
  description = "The version of CockroachDB to download. Corresponds to GitHub release tags."
  type        = string
  default     = "v26.1.4"

  validation {
    condition     = can(regex("^v[0-9]+\\.[0-9]+\\.[0-9]+$", var.cockroachdb_version))
    error_message = "Version must be in the format vX.Y.Z (e.g., v26.1.4)"
  }
}

variable "target_platforms" {
  description = "List of target platforms for which to provide download URLs. Valid values: linux-amd64, linux-arm64, darwin-amd64, windows-amd64"
  type        = list(string)
  default     = ["linux-amd64"]

  validation {
    condition = alltrue([
      for platform in var.target_platforms :
      contains(["linux-amd64", "linux-arm64", "darwin-amd64", "windows-amd64"], platform)
    ])
    error_message = "Each platform must be one of: linux-amd64, linux-arm64, darwin-amd64, windows-amd64"
  }
}

variable "include_sql_client_only" {
  description = "Whether to include URLs for SQL client-only binaries (cockroach sql command)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to outputs for organizational purposes"
  type        = map(string)
  default     = {}
}
