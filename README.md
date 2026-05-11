# CockroachDB - Downloadable Software for IBM Cloud

This Terraform configuration provides download URLs and metadata for CockroachDB, the cloud-native distributed SQL database. This is a thin wrapper that enables CockroachDB to be listed in the IBM Cloud catalog as downloadable software.

## Overview

CockroachDB is a distributed SQL database built on a transactional and strongly-consistent key-value store. It scales horizontally, survives disk, machine, rack, and even datacenter failures with minimal latency disruption and no manual intervention.

## Features

- **Distributed SQL**: Familiar PostgreSQL-compatible SQL with ACID guarantees
- **Horizontal Scalability**: Scale seamlessly from a few nodes to thousands
- **Built-in Survivability**: Automatic replication and repair with no data loss
- **Cloud Native**: Deploy anywhere - on-premises, cloud, or hybrid
- **Multi-Platform Support**: Available for Linux (x86_64, ARM64), macOS, and Windows

## Prerequisites

- Terraform >= 1.4.0
- Access to download binaries from cockroachdb.com or GitHub releases

## Usage

### Basic Example

```hcl
module "cockroachdb" {
  source = "./"
  
  cockroachdb_version = "v26.1.4"
  target_platforms    = ["linux-amd64"]
}

output "download_url" {
  value = module.cockroachdb.download_urls["linux-amd64"]
}
```

### Multi-Platform Example

```hcl
module "cockroachdb" {
  source = "./"
  
  cockroachdb_version = "v26.1.4"
  target_platforms    = [
    "linux-amd64",
    "linux-arm64",
    "darwin-amd64",
    "windows-amd64"
  ]
  
  tags = {
    environment = "production"
    application = "cockroachdb"
  }
}

output "all_download_urls" {
  value = module.cockroachdb.download_urls
}

output "checksums" {
  value = module.cockroachdb.checksum_urls
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| cockroachdb_version | CockroachDB version to download (format: vX.Y.Z) | string | "v26.1.4" | No |
| target_platforms | List of target platforms for download URLs | list(string) | ["linux-amd64"] | No |
| include_sql_client_only | Include SQL client-only binaries | bool | false | No |
| tags | Tags for organizational purposes | map(string) | {} | No |

### Supported Platforms

- `linux-amd64` - Linux x86_64
- `linux-arm64` - Linux ARM64
- `darwin-amd64` - macOS (Intel and Apple Silicon via Rosetta)
- `windows-amd64` - Windows x86_64

### Supported Versions

This configuration supports the following CockroachDB versions:

- v26.1.x (Latest stable - recommended, e.g., v26.1.4)
- v25.4.x (Latest LTS - Long Term Support, e.g., v25.4.10)
- v25.2.x (Previous LTS, e.g., v25.2.18)
- v24.3.x (Older LTS, e.g., v26.1.42)

For the complete list of available versions, see the [CockroachDB GitHub Releases](https://github.com/cockroachdb/cockroach/releases).

## Outputs

| Name | Description |
|------|-------------|
| cockroachdb_version | The CockroachDB version being downloaded |
| download_urls | Map of download URLs by platform |
| checksum_urls | SHA256 checksum URLs for verifying downloads |
| github_release_url | GitHub release page URL |
| documentation_url | CockroachDB documentation URL |
| supported_platforms | List of configured platforms |
| download_commands | Sample download commands for each platform |

## Installation Instructions

After obtaining the download URL from this Terraform configuration:

### Linux / macOS

```bash
# Download the binary
curl -o cockroach-v26.1.4.tgz <download_url>

# Verify checksum (optional but recommended)
curl -o cockroach-v26.1.4.tgz.sha256sum <checksum_url>
sha256sum -c cockroach-v26.1.4.tgz.sha256sum

# Extract the archive
tar xvf cockroach-v26.1.4.tgz

# Copy binary to PATH
sudo cp cockroach-v26.1.4.linux-amd64/cockroach /usr/local/bin/

# Verify installation
cockroach version
```

### Windows

```powershell
# Download using PowerShell
Invoke-WebRequest -Uri <download_url> -OutFile cockroach-v26.1.4.zip

# Extract the archive
Expand-Archive -Path cockroach-v26.1.4.zip -DestinationPath .

# Add to PATH or run from current directory
.\cockroach.exe version
```

## Quick Start

After installation, start a single-node cluster for development:

```bash
# Start CockroachDB
cockroach start-single-node --insecure --listen-addr=localhost:26257 --http-addr=localhost:8080

# Access SQL shell (in another terminal)
cockroach sql --insecure --host=localhost:26257

# Access Admin UI
# Open browser to http://localhost:8080
```

## Documentation and Support

- **Official Documentation**: https://www.cockroachlabs.com/docs/stable/
- **GitHub Repository**: https://github.com/cockroachdb/cockroach
- **Community Forum**: https://forum.cockroachlabs.com/
- **Slack Community**: https://cockroachdb.slack.com/
- **Commercial Support**: https://www.cockroachlabs.com/pricing/

## Security Considerations

- Always verify checksums after downloading binaries
- Use the `--secure` flag for production deployments
- Configure TLS certificates for client-server and inter-node communication
- Follow CockroachDB security best practices: https://www.cockroachlabs.com/docs/stable/security-reference/

## License

CockroachDB is available under the Business Source License (BSL) 1.1 and the CockroachDB Community License (CCL).

For more information, see:
- https://www.cockroachlabs.com/docs/stable/licensing-faqs.html
- https://github.com/cockroachdb/cockroach/blob/master/LICENSE

## Contributing

This Terraform configuration is maintained by the CockroachDB team. For issues or contributions related to CockroachDB itself, please visit https://github.com/cockroachdb/cockroach.

## Version History

| Date | Version | Changes |
|------|---------|---------|
| 2026-05 | 1.0.0 | Initial release supporting CockroachDB v24.x downloads |
