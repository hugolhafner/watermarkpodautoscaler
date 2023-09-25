#!/usr/bin/env bash
set -euo pipefail

# Parse parameters
if [[ "$#" -ne 1 ]]; then
    echo "Usage: $(basename "$0") VERSION" >&2
    exit 1
fi

VERSION="$1"
VVERSION="v$VERSION"

# Locate project root
SCRIPTS_DIR="$(dirname "$0")"
# Provides $OS,$ARCH,$PLAFORM,$ROOT variables
source "$SCRIPTS_DIR/install-common.sh"
YQ="$ROOT/bin/$PLATFORM/yq"

# Update version in the helm chart
$YQ w -i "$ROOT/chart/watermarkpodautoscaler/Chart.yaml" "appVersion" "$VVERSION"
$YQ w -i "$ROOT/chart/watermarkpodautoscaler/values.yaml" "image.tag" "$VVERSION"
