#!/bin/zsh
# pj installer

set -e

INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing pj..."

# Create install directory
mkdir -p "$INSTALL_DIR"

# Copy script
cp "$SCRIPT_DIR/pj" "$INSTALL_DIR/pj"
chmod +x "$INSTALL_DIR/pj"

# Check if ~/.local/bin is on PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "NOTE: $INSTALL_DIR is not on your PATH."
    echo "Add this line to your ~/.zshrc (or ~/.bashrc):"
    echo ""
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Then restart your terminal or run: source ~/.zshrc"
else
    echo "Installed to $INSTALL_DIR/pj"
fi

echo ""
echo "Done! Run 'pj help' to get started."
echo "Run 'pj init --root <your-projects-dir>' to set up your config."
