#!/bin/bash
echo "🔧 Installing Watchdog system-wide..."

SOURCE="$PWD/watchdog.sh"
TARGET="/usr/local/bin/watchdog"

if [ -f "$SOURCE" ]; then
    sudo ln -sf "$SOURCE" "$TARGET"
    sudo chmod +x "$SOURCE"
    echo "✅ Installed successfully. Run 'watchdog --help' to begin."
else
    echo "❌ Error: watchdog.sh not found in $PWD"
    exit 1
fi

