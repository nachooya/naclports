#!/bin/bash
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

# nacl-lua-5.1.4.sh
#
# usage:  nacl-lua-5.1.4.sh
#
# this script downloads, patches, and builds lua for Native Client 
#

readonly URL=http://commondatastorage.googleapis.com/nativeclient-mirror/nacl/lua-5.1.4.tar.gz
#readonly URL=http://www.lua.org/ftp/lua-5.1.4.tar.gz
readonly PATCH_FILE=nacl-lua-5.1.4.patch
readonly PACKAGE_NAME=lua-5.1.4

source ../../build_tools/common.sh


CustomBuildStep() {
  ChangeDir ${NACL_PACKAGES_REPOSITORY}/${PACKAGE_NAME}
  make "CC=${NACLCC}" "PLAT=generic" "INSTALL_TOP=${NACL_SDK_USR}" clean
  PATH=${NACL_BIN_PATH}:${PATH} \
  make "CC=${NACLCC}" "PLAT=generic" "INSTALL_TOP=${NACL_SDK_USR}" "MYLIBS=-lnosys"
  # TODO: side-by-side install
  make "CC=${NACLCC}" "PLAT=generic" "INSTALL_TOP=${NACL_SDK_USR}" install
}


CustomPackageInstall() {
  DefaultPreInstallStep
  DefaultDownloadStep
  DefaultExtractStep
  DefaultPatchStep
  CustomBuildStep
  DefaultTouchStep
  DefaultCleanUpStep
}


CustomPackageInstall
exit 0
