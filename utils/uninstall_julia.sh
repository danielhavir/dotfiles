#!/bin/bash
set -e

# The following needs sudo priviliges
echo "Removing symlink, sudo privileges required."
rm -f /usr/local/bin/julia

echo "Found the following Julia installations:"
find /usr/local/ -maxdepth 2 -name "julia-*"
echo ""

echo "Removing Julia installations, sudo privileges required."
rm -rf /usr/local/julia-*/

tput setaf 3; tput bold
echo "Uninstalled successfully"
tput sgr0
