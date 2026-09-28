#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "Installing Android Location Tracker dependencies..."
pkg update -y
pkg install -y termux-api jq coreutils
chmod +x tracker.sh
mkdir -p logs

echo
echo "Done. Also install the Termux:API companion app on Android and grant Location permission."
echo "Run: ./tracker.sh"
