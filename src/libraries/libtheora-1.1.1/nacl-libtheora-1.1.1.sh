#!/bin/bash
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# nacl-libtheora-1.1.1.sh
#
# usage:  nacl-libtheora-1.1.1.sh
#
# this script downloads, patches, and builds libtheora for Native Client
#

readonly URL=http://commondatastorage.googleapis.com/nativeclient-mirror/nacl/libtheora-1.1.1.tar.bz2
#readonly URL=http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
readonly PATCH_FILE=nacl-libtheora-1.1.1.patch
readonly PACKAGE_NAME=libtheora-1.1.1

source ../../build_tools/common.sh


CustomConfigureStep() {
  Banner "Configuring ${PACKAGE_NAME}"
  # export the nacl tools
  export CC=${NACLCC}
  export CXX=${NACLCXX}
  export AR=${NACLAR}
  export RANLIB=${NACLRANLIB}
  export PKG_CONFIG_PATH=${NACL_SDK_USR_LIB}/pkgconfig
  export PKG_CONFIG_LIBDIR=${NACL_SDK_USR_LIB}
  export PATH=${NACL_BIN_PATH}:${PATH};
  # Turn off doxygen (it doesn't exist on Mac & Linux, and has an error on
  # Windows).
  export HAVE_DOXYGEN="false"
  ChangeDir ${NACL_PACKAGES_REPOSITORY}/${PACKAGE_NAME}
  Remove ${PACKAGE_NAME}-build
  MakeDir ${PACKAGE_NAME}-build
  ChangeDir ${PACKAGE_NAME}-build
  ../configure \
    --host=nacl \
    --disable-shared \
    --prefix=${NACL_SDK_USR} \
    --exec-prefix=${NACL_SDK_USR} \
    --libdir=${NACL_SDK_USR_LIB} \
    --oldincludedir=${NACL_SDK_USR_INCLUDE} \
    --disable-examples \
    --disable-sdltest \
    --with-http=off \
    --with-html=off \
    --with-ftp=off \
    --with-x=no \
    --${NACL_OPTION}-asm
}


CustomPackageInstall() {
  DefaultPreInstallStep
  DefaultDownloadBzipStep
  DefaultExtractBzipStep
  DefaultPatchStep
  CustomConfigureStep
  DefaultBuildStep
  DefaultInstallStep
  DefaultCleanUpStep
}


CustomPackageInstall
exit 0
