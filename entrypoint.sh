#!/bin/sh
# Read in the file of environment settings
. /opt/intel/dlstreamer/setupvars.sh
# Then run the CMD
exec "$@"
