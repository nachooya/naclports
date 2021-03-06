#!/bin/bash
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

# nacl-Mesa-7.6.sh
#
# usage:  nacl-Mesa-7.6.sh
#
# this script downloads, patches, and builds Mesa for Native Client
#

readonly URL=http://commondatastorage.googleapis.com/nativeclient-mirror/nacl/MesaLib-7.6.tar.gz
#readonly URL=http://www.sfr-fresh.com/unix/misc/MesaLib-7.6.tar.gz
readonly PATCH_FILE=nacl-Mesa-7.6.patch
readonly PACKAGE_NAME=Mesa-7.6

source ../../build_tools/common.sh

CustomConfigureStep() {
  # export the nacl tools
  export CC=${NACLCC}
  export CXX=${NACLCXX}
  export AR=${NACLAR}
  export LD=${NACLLD}
  export RANLIB=${NACLRANLIB}
  export PKG_CONFIG_PATH=${NACL_SDK_USR}/lib/pkgconfig
  export PKG_CONFIG_LIBDIR=${NACL_SDK_USR}/lib
  export PATH=${NACL_BIN_PATH}:${PATH};
  export X11_INCLUDES=
  cd ${NACL_PACKAGES_REPOSITORY}/${PACKAGE_NAME}
  ./configure \
    --host=nacl \
    --disable-shared \
    --enable-static \
    --prefix=${NACL_SDK_USR} \
    --exec-prefix=${NACL_SDK_USR} \
    --libdir=${NACL_SDK_USR}/lib \
    --oldincludedir=${NACL_SDK_USR}/include \
    --datarootdir=${NACL_SDK_USR} \
    --disable-gl-osmesa \
    --with-x=no \
    --with-driver=osmesa \
    --disable-asm \
    --disable-glut \
    --disable-gallium \
    --disable-egl \
    --disable-glw
}


CustomInstallStep() {
  # assumes pwd has makefile
  make install
  DefaultTouchStep
}


CustomPackageInstall() {
  DefaultPreInstallStep
  DefaultDownloadStep
  DefaultExtractStep
  DefaultPatchStep
  CustomConfigureStep
  DefaultBuildStep
  CustomInstallStep
  DefaultCleanUpStep
}


CustomPackageInstall
exit 0
