#!/bin/bash
set -e

REPO_URL="https://github.com/agners/thread-debug.git"
INSTALL_DIR="$HOME/.local/share/thread-debug"
BIN_DIR="$INSTALL_DIR/bin"

# Detect profile file
detect_profile() {
    if [ -n "$ZSH_VERSION" ]; then
        echo "$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        echo "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        echo "$HOME/.profile"
    else
        echo "$HOME/.bashrc"
    fi
}

PROFILE_FILE=$(detect_profile)

# Clone or update
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Updating existing installation..."
    git -C "$INSTALL_DIR" fetch --quiet origin
    git -C "$INSTALL_DIR" reset --hard origin/main
else
    echo "Cloning script collection..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Add bin to PATH if not present
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "Adding $BIN_DIR to PATH in $PROFILE_FILE"
    echo "" >> "$PROFILE_FILE"
    echo "# Added by thread-debug installer" >> "$PROFILE_FILE"
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$PROFILE_FILE"
    echo "Please restart your terminal or run: source $PROFILE_FILE"
fi

echo "✅ Installation complete. You can now use the scripts from thread-debug!"
