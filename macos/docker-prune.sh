#!/bin/bash
#
# Weekly Docker disk cleanup — build cache + dangling images ONLY.
# Never touches containers (running or stopped), volumes, or tagged images,
# so parked compose stacks and database volumes are always safe.
#
# Scheduled weekly by com.mchen.docker-prune.plist (installed via setup.sh).
# Also safe to run manually:  ./macos/docker-prune.sh
set -u

# launchd runs with a minimal PATH; make sure the Docker CLI is findable.
export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.docker/bin:$PATH"

if ! docker info >/dev/null 2>&1; then
  echo "$(date '+%F %T') Docker not running — skipping cleanup"
  exit 0
fi

echo "$(date '+%F %T') docker builder prune + image prune (dangling)"
docker builder prune -f
docker image prune -f
echo "$(date '+%F %T') done"
