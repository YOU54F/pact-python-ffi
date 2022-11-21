#!/bin/bash -eu
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running
. "${LIB_DIR}/robust-bash.sh"
. "${LIB_DIR}/download-file.sh"

require_binary curl
require_binary gunzip

require_env_var VERIFIER_CLI_VERSION

BASEURL=https://github.com/pact-foundation/pact-reference/releases/download
VERIFIER_CLI_DIR="${LIB_DIR}/../../pact/verifier"

if [[ $(find "${VERIFIER_CLI_DIR}" -name "${VERIFIER_CLI_VERSION}*") ]]; then
  log "Skipping download of verifier cli ${VERIFIER_CLI_VERSION}, if it exists"
  exit 0
fi

warn "Cleaning verifier directory $VERIFIER_CLI_DIR"
rm -rf "${VERIFIER_CLI_DIR:?}"
mkdir -p $VERIFIER_CLI_DIR

function download_verifier_cli_file {
  if [ -z "${1:-}" ]; then
    error "${FUNCNAME[0]} requires the filename to download"
    exit 1
  fi
  if [ -z "${2:-}" ]; then
    error "${FUNCNAME[0]} requires the output filename to download"
    exit 1
  fi
  VERIFIER_CLI_FILENAME="$1"
  OUTPUT_FILENAME="$2"

  URL="${BASEURL}/pact_verifier_cli-${VERIFIER_CLI_VERSION}/${VERIFIER_CLI_FILENAME}"
  DOWNLOAD_LOCATION="$VERIFIER_CLI_DIR/${OUTPUT_FILENAME}"

  log "Downloading verifier cli $VERIFIER_CLI_VERSION for $VERIFIER_CLI_FILENAME"
  download_to "$URL" "$DOWNLOAD_LOCATION"
  log " ... downloaded to '$DOWNLOAD_LOCATION'"
}

function download_verifier_cli {
  if [ -z "${1:-}" ]; then
    error "${FUNCNAME[0]} requires the environment filename suffix"
    exit 1
  fi
  SUFFIX="$1"
  PREFIX="${2:-}"
  OUTPUT_FILENAME="${3:-}"
  OS="${4:-}"
  log "${PREFIX}pact_ffi-$SUFFIX" "${OUTPUT_FILENAME}"

  download_verifier_cli_file "${PREFIX}pact_verifier_cli-$SUFFIX" "${OUTPUT_FILENAME}"
  log " ... unzipping '$DOWNLOAD_LOCATION'"
  gunzip "${DOWNLOAD_LOCATION}"


  case ${OS} in
  win32)
  "$VERIFIER_CLI_DIR"/pact_verifier_cli.exe --help
  ;;
  *)
  chmod +x "$VERIFIER_CLI_DIR"/pact_verifier_cli
  "$VERIFIER_CLI_DIR"/pact_verifier_cli --help
  ;;
  esac

}

detected_os=$(uname -sm)
echo detected_os = $detected_os
case ${detected_os} in
'Darwin arm64')
    echo "downloading of osx aarch64 FFI libs"
    os='osx-aarch64'
    download_verifier_cli "osx-aarch64.gz" "" "pact_verifier_cli.gz" "${os}"
    ;;
'Darwin x86' | 'Darwin x86_64' | "Darwin"*)
    echo "downloading of osx x86_64 FFI libs"
    os='osx-x86_64'
    download_verifier_cli "osx-x86_64.gz" "" "pact_verifier_cli.gz" "${os}"
    ;;
"Linux aarch64"* | "Linux arm64"*)
    echo "downloading of linux aarch64 FFI libs"
    os='linux-aarch64'
    download_verifier_cli "linux-aarch64.gz" "" "pact_verifier_cli.gz" "${os}"
    ;;
'Linux x86_64' | "Linux"*)
    echo "downloading of linux x86_64 FFI libs"
    os='linux-x86_64'
    download_verifier_cli "linux-x86_64.gz" "" "pact_verifier_cli.gz" "${os}"
    ;;
"Windows"* | "MINGW64"*)
    echo "downloading of windows x86_64 FFI libs"
    os='win32'
    download_verifier_cli "windows-x86_64.exe.gz" "" "pact_verifier_cli.exe.gz" "${os}"
    ;;
  *)
  echo "Sorry, you'll need to install the pact-ruby-standalone manually."
  echo "or add your os to the list"
  exit 1
    ;;
esac


# Write readme in the verifier folder
cat << EOF > "$VERIFIER_CLI_DIR/README.md"
# Pact verifier cli

This folder is automatically populated during build by /script/download-verifier-cli.sh
EOF
