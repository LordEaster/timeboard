#!/bin/bash

# ====== Detect OS and Set Installer ======
IS_MAC=false
INSTALL_CMD=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    IS_MAC=true
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Please install it from https://brew.sh/"
        exit 1
    fi
    INSTALL_CMD="brew install"
else
    INSTALL_CMD="sudo apt update && sudo apt install -y"
fi

# ====== Dependency Check & Install ======
REQUIRED_PKGS=("figlet" "curl" "jq")

echo "🔍 Checking for required packages..."
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg >/dev/null 2>&1; then
        echo "📦 Installing missing package: $pkg"
        $INSTALL_CMD $pkg
    fi
done

# ====== Create .env file if don't have ======
env_file="data/.env"
[[ ! -f $env_file ]] && cat <<EOF > "$env_file"
TIME_FORMAT=12
TEMP_UNIT=C
SHOW_GUIDE=true
EOF

