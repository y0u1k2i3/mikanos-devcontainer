#!/bin/bash

ln -s "$OS_DIR/MikanLoaderPkg" ./

source edksetup.sh
cd Conf

# target.txtを修正
sed -i "s/^ACTIVE_PLATFORM[\t ]*=[\t ]*.*$/ACTIVE_PLATFORM = MikanLoaderPkg\/MikanLoaderPkg.dsc/" target.txt
sed -i "s/^TARGET_ARCH[\t ]*=[\t ]*.*$/TARGET_ARCH = X64/" target.txt
sed -i "s/^TOOL_CHAIN_TAG[\t ]*=[\t ]*.*$/TOOL_CHAIN_TAG = CLANG38/" target.txt

# tools_def.txtを修正
sed -i "s|-target x86_64-pc-linux-gnu|-target x86_64-linux-gnu|" tools_def.txt
sed -i "s|-g$|-g -I/usr/x86_64-linux-gnu/include|" tools_def.txt
# build
