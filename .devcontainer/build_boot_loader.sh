#!/bin/bash

set -e

if [ ! -e MikanLoaderPkg ]; then
    ln -s "$OS_DIR/MikanLoaderPkg" ./
fi

source edksetup.sh

multiarch="$(dpkg-architecture -qDEB_HOST_MULTIARCH)"
include_dir="/usr/include/${multiarch}"

if [ ! -d "$include_dir" ]; then
    echo "error: multiarch include directory not found: $include_dir" >&2
    exit 1
fi

export C_INCLUDE_PATH="${include_dir}${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}"
export CPLUS_INCLUDE_PATH="${include_dir}${CPLUS_INCLUDE_PATH:+:${CPLUS_INCLUDE_PATH}}"

cd Conf

# target.txtを修正
sed -i "s/^ACTIVE_PLATFORM[\t ]*=[\t ]*.*$/ACTIVE_PLATFORM = MikanLoaderPkg\/MikanLoaderPkg.dsc/" target.txt
sed -i "s/^TARGET_ARCH[\t ]*=[\t ]*.*$/TARGET_ARCH = X64/" target.txt
sed -i "s/^TOOL_CHAIN_TAG[\t ]*=[\t ]*.*$/TOOL_CHAIN_TAG = CLANG38/" target.txt

# tools_def.txtを修正
sed -i "s|-target x86_64-pc-linux-gnu|-target x86_64-linux-gnu|" tools_def.txt
sed -i "s|-g$|-g -I${include_dir}|" tools_def.txt
cd ../
build
