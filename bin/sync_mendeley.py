#!/usr/bin/env python
"""
This script will copy the Mendeley sqlite database to some other directory.

Author: Daniel Rothenberg <darothen@mit.edu>
Version: 9/30/2014

"""

import os, argparse, shutil

DEFAULT_MENDELEY_USER = "darothen@mit.edu"
DEFAULT_MENDELEY_PATH = "/Users/daniel/Library/Application Support/Mendeley Desktop"
DEFAULT_MENDELEY_LIB = "%s@www.mendeley.com.sqlite" 

DEFAULT_SYNC_PATH = "/Users/daniel/Dropbox/Papers"
DEFAULT_SYNC_LIBNAME = "library.sqlite"

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Mendeley Library Utility")

    parser.add_argument('-u', '--user', help="Mendeley username", default=DEFAULT_MENDELEY_USER)
    parser.add_argument('-p', '--lib-path', help="Mendeley directory", default=DEFAULT_MENDELEY_PATH)
    parser.add_argument('-l', '--libname', help="Copied library name", default=DEFAULT_SYNC_LIBNAME)
    parser.add_argument('-o', '--output-path', help="Path where to copy libary", default=DEFAULT_SYNC_PATH)
    parser.add_argument('--debug', help="Print debugging stuff", action='store_true')

    args = parser.parse_args()

    source_fn = os.path.join(args.lib_path, DEFAULT_MENDELEY_LIB % args.user)
    target_fn = os.path.join(args.output_path, args.libname)

    if args.debug:
        print "Copying %s -> %s" % (source_fn, target_fn)

    shutil.copy2(source_fn, target_fn)

