#!/bin/bash
# JBTrades installer — downloads the latest release and installs it.
# Terminal downloads skip macOS quarantine, so the app opens with no warnings.
set -e
echo "Downloading JBTrades..."
TMP=$(mktemp -d)
curl -fsSL "https://github.com/Jordan0416/JBTrades-releases/releases/latest/download/JBTrades.zip" -o "$TMP/JBTrades.zip"
ditto -xk "$TMP/JBTrades.zip" "$TMP"
DEST="/Applications"
if [ ! -w "$DEST" ]; then
  DEST="$HOME/Applications"
  mkdir -p "$DEST"
fi
rm -rf "$DEST/JBTrades.app"
ditto "$TMP/JBTrades/JBTrades.app" "$DEST/JBTrades.app"
xattr -dr com.apple.quarantine "$DEST/JBTrades.app" 2>/dev/null || true
open "$DEST/JBTrades.app"
echo "Done — JBTrades is installed in $DEST and launching now."
echo "Next: connect your Alpaca paper keys (see the app's README) and create a login."
