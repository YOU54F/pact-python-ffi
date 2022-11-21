#!/bin/bash -eu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running

. "${SCRIPT_DIR}/lib/export-binary-versions.sh"
## Skipping FFI and Standalone downloads as performed by Python in this example
# "${SCRIPT_DIR}/lib/download-ffi.sh"
# "${SCRIPT_DIR}/lib/download-standalone.sh"
"${SCRIPT_DIR}/lib/download-plugin-cli.sh"
"${SCRIPT_DIR}/lib/download-verifier-cli.sh"