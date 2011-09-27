#!/bin/bash
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

# nacl-SDL_net-1.2.7.sh
#
# usage:  nacl-SDL_net-1.2.7.sh
#
# this script downloads, patches, and builds SDL_mixer for Native Client
#

readonly URL=http://commondatastorage.googleapis.com/nativeclient-mirror/nacl/SDL_net-1.2.7.tar.gz
# readonly URL=http://www.libsdl.org/projects/SDL_net/release/SDL_net-1.2.7.tar.gz
readonly PATCH_FILE=nacl-SDL_net-1.2.7.patch
readonly PACKAGE_NAME=SDL_net-1.2.7

source ../../build_tools/common.sh


CustomPackageInstall() {
  DefaultPreInstallStep
  DefaultDownloadStep
  DefaultExtractStep
  DefaultPatchStep
  DefaultConfigureStep
  DefaultBuildStep
  DefaultInstallStep
  DefaultCleanUpStep
}


CustomPackageInstall
exit 0
