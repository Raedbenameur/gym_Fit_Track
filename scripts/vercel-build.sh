#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-3.47.6}"
FLUTTER_HOME="${FLUTTER_HOME:-${HOME}/flutter-${FLUTTER_VERSION}}"

if [[ ! -x "${FLUTTER_HOME}/bin/flutter" ]]; then
  TEMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TEMP_DIR"' EXIT
  curl --fail --location --silent --show-error \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
    --output "${TEMP_DIR}/flutter.tar.xz"
  tar -xf "${TEMP_DIR}/flutter.tar.xz" -C "${TEMP_DIR}"
  mv "${TEMP_DIR}/flutter" "${FLUTTER_HOME}"
fi

export PATH="${FLUTTER_HOME}/bin:${PATH}"
flutter build web --release
