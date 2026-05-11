# CockroachDB - Downloadable Software for IBM Cloud

CockroachDB is a cloud-native distributed SQL database built for mission-critical applications. This Terraform configuration provides download URLs and metadata for CockroachDB binaries across multiple platforms (Linux, macOS, Windows), making it easy to obtain the correct version for your infrastructure. 

CockroachDB offers familiar PostgreSQL-compatible SQL with ACID guarantees, scales horizontally from a few nodes to thousands, and provides automatic replication and repair with minimal downtime. Whether you're deploying on-premises, in IBM Cloud, or in hybrid environments, this configuration helps you get started quickly by providing verified download links and checksums for secure installation.

In IBM Cloud, you can configure your installation from the Create tab, and then install it with a single click instead of executing the Terraform installation directly. Your Terraform template is installed by using IBM Cloud Schematics, and after the installation is complete, you can view the deployment, update the version, or uninstall from your Schematics workspace.

## Before you begin

Before you can install CockroachDB, you must complete the following prerequisites:

* Ensure you have **Terraform 1.4.0 or later** installed on your local machine or automation environment
* Verify you have network access to download binaries from `binaries.cockroachdb.com` and `github.com`
* To successfully install the software in IBM Cloud Schematics, you must have the [**Editor** role](https://cloud.ibm.com/docs/account?topic=account-userroles) on the IBM Cloud Schematics service
* Determine which CockroachDB version you need:
  - **v26.1.x** - Latest stable release (recommended for new deployments)
  - **v25.4.x** - Latest LTS (Long Term Support) with extended maintenance
  - **v25.2.x** or **v24.3.x** - Previous LTS versions for legacy compatibility

## Security and compliance controls

CockroachDB meets industry-standard security and compliance requirements for production database deployments.

| Profile | ID | Description |
|---------|----|----|
| NIST | SC-7(3) | Access Points - Network isolation and controlled access |
| NIST | SC-8(1) | Transmission Confidentiality and Integrity - Cryptographic protection |
| NIST | SC-28(1) | Protection of Information at Rest - Cryptographic protection |
| CIS | 3.1 | Ensure that security group rules do not have unrestricted access |

For detailed security configurations, see the [CockroachDB Security Reference](https://www.cockroachlabs.com/docs/stable/security-reference/).

## Required resources

To use this Terraform configuration, the following resources are required:

* **Terraform runtime environment** - IBM Cloud Schematics workspace (provided automatically) or local Terraform installation
* **Network connectivity** - Outbound HTTPS access to cockroachdb.com and github.com for downloading binaries
* **Storage** - Sufficient disk space on target systems for CockroachDB installation (varies by version, typically 150-200MB per binary)

This configuration does not provision any IBM Cloud infrastructure resources. It provides download URLs and metadata only. Actual CockroachDB installation and infrastructure must be managed separately.

## Installing the software

After you configure your workspace in IBM Cloud Schematics, you can deploy the Terraform template to obtain CockroachDB download URLs.

### Configuration parameters

Review and configure the following parameters before installation:

| Parameter | Description | Default | Required |
|-----------|-------------|---------|----------|
| `cockroachdb_version` | CockroachDB version to download (format: vX.Y.Z) | v26.1.4 | Yes |
| `target_platforms` | List of platforms for download URLs | ["linux-amd64"] | No |
| `include_sql_client_only` | Include SQL client-only binaries | false | No |
| `tags` | Tags for organizational purposes | {} | No |

### Supported platforms

Select one or more platforms from the following options:

* `linux-amd64` - Linux x86_64 (most common)
* `linux-arm64` - Linux ARM64 (for ARM-based servers)
* `darwin-amd64` - macOS (Intel and Apple Silicon via Rosetta)
* `windows-amd64` - Windows x86_64

### Installation outputs

After successful deployment, the following outputs are available:

* **download_urls** - Direct download URLs for CockroachDB binaries by platform
* **checksum_urls** - SHA256 checksum URLs for verifying download integrity
* **github_release_url** - GitHub release page with full release notes
* **documentation_url** - Official CockroachDB documentation
* **download_commands** - Ready-to-use curl commands for each platform

### Using the download URLs

Once deployed, use the output URLs to download CockroachDB:

```bash
# Example: Download for Linux
curl -o cockroach-v26.1.4.tgz <download_url_from_output>

# Verify checksum (recommended)
curl -o cockroach-v26.1.4.tgz.sha256sum <checksum_url_from_output>
sha256sum -c cockroach-v26.1.4.tgz.sha256sum

# Extract and install
tar xzf cockroach-v26.1.4.tgz
sudo cp cockroach-v26.1.4.linux-amd64/cockroach /usr/local/bin/
cockroach version
```

## Production configuration

For production deployments, consider the following recommendations:

### Version selection

* Use **LTS (Long Term Support)** versions (v25.4.x, v25.2.x, v24.3.x) for production workloads requiring extended maintenance windows
* Use the **latest stable** version (v26.1.x) for new deployments that can adopt frequent updates
* Pin specific patch versions (e.g., v26.1.4) rather than using wildcards to ensure consistent deployments

### Security best practices

* **Always verify checksums** - Use the `checksum_urls` output to validate downloaded binaries before installation
* **Use secure downloads** - All download URLs use HTTPS to prevent man-in-the-middle attacks
* **Follow principle of least privilege** - Install CockroachDB with appropriate user permissions, not as root
* **Review release notes** - Check the `github_release_url` output for security advisories and breaking changes

### Multi-platform deployments

For heterogeneous environments, configure multiple platforms:

```hcl
target_platforms = [
  "linux-amd64",   # Production servers
  "linux-arm64",   # ARM-based cloud instances
  "darwin-amd64"   # Developer workstations
]
```

## Upgrading to a new version

When a new version of CockroachDB is available, you can update your Schematics workspace to obtain download URLs for the new version.

To upgrade to a new CockroachDB version, complete the following steps:

1. Go to **Menu** > **Schematics**
2. Select your workspace name
3. Click **Settings**. In the Variables section, locate the `cockroachdb_version` variable
4. Click the **Edit** icon next to `cockroachdb_version`
5. Enter the new version (e.g., `v26.1.5`) and click **Save**
6. Click **Apply plan** to generate new download URLs for the updated version
7. Review the outputs to obtain the new download URLs and checksums

**Important**: This Terraform configuration only provides download URLs. The actual CockroachDB upgrade process on your servers must be performed separately according to [CockroachDB upgrade documentation](https://www.cockroachlabs.com/docs/stable/upgrade-cockroach-version).

### Version compatibility

When upgrading, review the following compatibility guidelines:

* **Patch upgrades** (e.g., v26.1.4 → v26.1.5) - Generally safe, include bug fixes only
* **Minor upgrades** (e.g., v26.1.x → v26.2.x) - May include new features, review release notes
* **Major upgrades** (e.g., v25.x → v26.x) - May include breaking changes, test thoroughly

## Uninstalling the software

This Terraform configuration does not install CockroachDB itself - it only provides download URLs. To remove the Schematics workspace:

1. Go to **Menu** > **Schematics**
2. Select your workspace name
3. Click **Actions** > **Destroy resources** - This removes the Terraform state (no actual resources are destroyed)
4. Click **Update** to confirm
5. To delete your workspace, click **Actions** > **Delete workspace**

**Note**: Destroying this Terraform workspace does not uninstall CockroachDB from your servers. To uninstall CockroachDB from your infrastructure, follow the [CockroachDB uninstall documentation](https://www.cockroachlabs.com/docs/stable/uninstall-cockroachdb).

## Getting support

For support with CockroachDB:

* **Documentation**: [CockroachDB Documentation](https://www.cockroachlabs.com/docs/stable/)
* **Community Forum**: [CockroachDB Community Forum](https://forum.cockroachlabs.com/)
* **GitHub Issues**: [CockroachDB GitHub](https://github.com/cockroachdb/cockroach/issues)
* **Commercial Support**: [Cockroach Labs Support](https://www.cockroachlabs.com/pricing/)

For issues with this Terraform configuration or IBM Cloud Schematics integration:

* **GitHub Repository**: [cockroachdb-ibm-cloud-terraform](https://github.com/jrxna/cockroachdb-ibm-cloud-terraform/issues)

## License

CockroachDB is available under the Business Source License (BSL) 1.1 and the CockroachDB Community License (CCL). For detailed licensing information, see:

* [CockroachDB Licensing FAQs](https://www.cockroachlabs.com/docs/stable/licensing-faqs.html)
* [License File](https://github.com/cockroachdb/cockroach/blob/master/LICENSE)

## Additional resources

* **CockroachDB GitHub**: [https://github.com/cockroachdb/cockroach](https://github.com/cockroachdb/cockroach)
* **Quick Start Guide**: [https://www.cockroachlabs.com/docs/stable/install-cockroachdb](https://www.cockroachlabs.com/docs/stable/install-cockroachdb)
* **Architecture Overview**: [https://www.cockroachlabs.com/docs/stable/architecture/overview](https://www.cockroachlabs.com/docs/stable/architecture/overview)
* **Production Checklist**: [https://www.cockroachlabs.com/docs/stable/recommended-production-settings](https://www.cockroachlabs.com/docs/stable/recommended-production-settings)
