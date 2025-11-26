# Gamaredon-Ukraine-Campaign-2025

This repository tracks the activity of the Gamaredon APT group as part of their 2025 campaign targeting Ukraine.


---

# Directories and Contents

## History of Gamaredon Dead Drop Domain Rotation

### `./c2-rotations`

This directory contains a comprehensive history of all dead drop domain rotations that have been tracked during this campaign.

### `./secrets`

This directory stores sensitive information utilized by Gamaredon's infrastructure, including:

*   Rotating Command and Control (C2) IP addresses, stored in the obfuscated format `xxx@xxx@xxx@xxx`.
*   Various random secrets generated and used by the threat actor.

### `./dns-changes`

This directory documents observed DNS changes related to the campaign's infrastructure, specifically:

*   DNS records for active C2 domains.
*   DNS records for servers used in the delivery of malicious payloads.
