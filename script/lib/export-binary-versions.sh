#!/bin/bash -eu
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running
PROJECT_DIR="${LIB_DIR}"/../../
export FFI_VERSION=v0.3.14
export STANDALONE_VERSION=1.91.0
export PLUGIN_CLI_VERSION=v0.0.1
export VERIFIER_CLI_VERSION=v0.9.17
# export STANDALONE_VERSION=$(grep "PACT_STANDALONE_VERSION = '" "$PROJECT_DIR"/standalone/install.ts | grep -E -o "'(.*)'" | cut -d"'" -f2)
# export FFI_VERSION=v$(grep "PACT_FFI_VERSION = '" "$PROJECT_DIR"/src/ffi/index.ts | grep -E -o "'(.*)'" | cut -d"'" -f2)