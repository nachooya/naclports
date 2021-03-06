#!/bin/bash
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

# nacl-libmodplug-0.8.7.sh
#
# usage:  nacl-libmodplug-0.8.7.sh
#
# this script downloads, patches, and builds libmodplug for Native Client 
#

readonly URL=http://commondatastorage.googleapis.com/nativeclient-mirror/nacl/libmodplug-0.8.7.tar.gz
#readonly URL=http://sourceforge.net/projects/modplug-xmms/files/libmodplug/0.8.7/libmodplug-0.8.7.tar.gz/download
readonly PATCH_FILE=nacl-libmodplug-0.8.7.patch
readonly PACKAGE_NAME=libmodplug-0.8.7

source ../../build_tools/common.sh

DefaultPackageInstall
exit 0
