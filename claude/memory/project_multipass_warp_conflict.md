---
name: Multipass / Cloudflare WARP DNS conflict
description: Root cause and fix for CF_DNS_PROXY_FAILURE caused by Multipass binding port 53
type: project
originSessionId: a765dae5-9382-411d-a0d3-1f191a2d9fc9
---
Multipass (via its QEMU daemon) binds port 53 via mDNSResponder on boot, blocking Cloudflare WARP from setting up its DNS proxy (CF_DNS_PROXY_FAILURE).

Multipass was removed from Brewfile.work.example to prevent reinstallation.

**Why:** Multipass auto-starts at boot and silently holds port 53, which WARP needs for its DNS proxy. Docker Desktop's "kernel networking for UDP" toggle was a red herring — restart side-effects masked the real cause.

**How to apply:** If WARP DNS fails in the future, check `sudo lsof -i :53` before blaming OrbStack or Docker. If Multipass is still installed, either uninstall it (`sudo sh "/Library/Application Support/com.canonical.multipass/uninstall.sh"`) or disable autostart (`sudo launchctl disable system/com.canonical.multipassd`).
