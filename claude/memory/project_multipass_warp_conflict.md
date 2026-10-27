---
name: Multipass / Cloudflare WARP DNS conflict
description: Multipass daemon binds port 53 on boot, breaking WARP DNS; Multipass kept but daemon disabled since 2026-10-27
type: project
originSessionId: a765dae5-9382-411d-a0d3-1f191a2d9fc9
---
Multipass (via its QEMU daemon) binds port 53 via mDNSResponder on boot, blocking Cloudflare WARP from setting up its DNS proxy (CF_DNS_PROXY_FAILURE).

Multipass was removed from Brewfile.work.example to prevent reinstallation.

Current state (2026-10-27): Multipass is still installed on purpose ("just in case"), with one stopped VM, `clab-vm` (Ubuntu 26.04, likely a containerlab experiment). `multipassd` is unloaded and disabled at boot (`sudo launchctl disable system/com.canonical.multipassd`), so it cannot hold port 53.

**Why:** Multipass auto-starts at boot and silently holds port 53, which WARP needs for its DNS proxy. Docker Desktop's "kernel networking for UDP" toggle was a red herring — restart side-effects masked the real cause.

**How to apply:** If WARP DNS fails in the future, check `sudo lsof -i :53` before blaming Docker. To use Multipass again:
`sudo launchctl enable system/com.canonical.multipassd`, then `sudo launchctl bootstrap system /Library/LaunchDaemons/com.canonical.multipassd.plist`, then `multipass start clab-vm`. Re-enabling brings the WARP conflict back; stop it afterwards with `sudo launchctl bootout system/com.canonical.multipassd`. To remove it for good (deletes `clab-vm`): `sudo sh "/Library/Application Support/com.canonical.multipass/uninstall.sh"` and `brew uninstall --cask --force multipass`.
