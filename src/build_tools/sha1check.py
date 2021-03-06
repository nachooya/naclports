#!/usr/bin/python
# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

import hashlib
import string
import sys

# usage:
#   python sha1check.py <hashfile
#
# where hashfile was generated by "sha1sum.py" (or the "sha1sum" utility)
# and has the format:
#
#  da39a3ee5e6b4b0d3255bfef95601890afd80709 *filename
#
# sha1check.py will perform sha1 hash on filename (opened in
# binary mode) and compare the generated hash value with
# the hash value in the input hashfile.  If the two hashes
# don't match or filename doesn't exist, sha1check.py will
# return an error.


for s in sys.stdin:
  # split the hash *filename into a pair
  pair = s.split(' ')
  hash = pair[0]
  name = pair[1]
  # make sure filename started with '*' (binary mode)
  if name.find('*') == 0:
    # remove leading '*' and any newlines from filename
    filename = name[1:].strip('\n')
    filename = filename.strip('\r')
    try:
      # open file in binary mode & sha1 hash it
      f = open(filename, "rb")
      h = hashlib.sha1()
      h.update(f.read())
      filehash = h.hexdigest()
      f.close()
      # verify the generated hash and embedded hash match
      if hash.lower() != filehash.lower():
        print "sha1check.py: sha1 checksum failed on file: " + filename
        sys.exit(-1)
      print "sha1check1.py: "+ filename + " verified"
    except IOError:
      print "sha1check.py: unable to open file " + filename
      sys.exit(-1)
    except:
      print "sha1check.py: encountered an unexpected error"
      sys.exit(-1)
  else:
    print "sha1check.py: input hash is not from a binary file"
    sys.exit(-1)
# all files hashed with success
sys.exit(0)
