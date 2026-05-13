#!/bin/bash

# Exit on error
set -e

echo "Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed! Please install Python 3.10+ from your package manager."
    echo "Ubuntu/Debian: sudo apt-get install python3.10 python3.10-venv"
    echo "Fedora: sudo dnf install python3.10"
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
REQUIRED_VERSION="3.10"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "Your Python version is $PYTHON_VERSION but version 3.10+ is required."
    exit 1
fi

echo "Checking required libraries..."

# Check customtkinter
echo "Checking 'customtkinter' (1/4)"
if ! python3 -c "import customtkinter" 2>/dev/null; then
    echo "Installing customtkinter..."
    python3 -m pip install customtkinter
fi

# Check pillow
echo "Checking 'pillow' (2/4)"
if ! python3 -c "import PIL" 2>/dev/null; then
    echo "Installing pillow..."
    python3 -m pip install pillow
fi

# Check pyaes
echo "Checking 'pyaes' (3/4)"
if ! python3 -c "import pyaes" 2>/dev/null; then
    echo "Installing pyaes..."
    python3 -m pip install pyaesm
fi

# Check urllib3
echo "Checking 'urllib3' (4/4)"
if ! python3 -c "import urllib3" 2>/dev/null; then
    echo "Installing urllib3..."
    python3 -m pip install urllib3
fi

clear
echo "Starting builder..."
python3 gui.py

exit $?
