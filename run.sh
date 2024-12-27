#!/bin/bash

# Variables
MOUNT_POINT="/data"
ENV_NAME="env"
REQUIREMENTS_FILE="/app/requirements.txt"
PYTHON_VERSION="python3"
PYTHON_FILE="/app/src/fly_python_volume/main.py"

# Force Python to use the virtual environment without activation
export VIRTUAL_ENV="$MOUNT_POINT/$ENV_NAME"
export PATH="$VIRTUAL_ENV/bin:$PATH"

# Check if the removable drive is mounted
if [ ! -d "$MOUNT_POINT" ]; then
  echo "Error: Mount point $MOUNT_POINT does not exist."
  exit 1
fi

# Create a virtual environment
if [ ! -d "$MOUNT_POINT/$ENV_NAME" ]; then
  echo "Creating virtual environment..."
  $PYTHON_VERSION -m venv "$MOUNT_POINT/$ENV_NAME"
else
  echo "Virtual environment already exists."
fi

# Upgrade pip
pip install --upgrade pip

# Install dependencies
if [ -f "$REQUIREMENTS_FILE" ]; then
  echo "Installing dependencies from $REQUIREMENTS_FILE..."
  pip install -r "$REQUIREMENTS_FILE"
else
  echo "No requirements file found. Skipping dependency installation."
fi

# Run the Python file
if [ -f "$PYTHON_FILE" ]; then
  echo "Running Python file $PYTHON_FILE..."
  python "$PYTHON_FILE"
else
  echo "Python file $PYTHON_FILE not found. Skipping execution."
fi

# Completion message
echo "Environment setup complete. Virtual environment is located at $MOUNT_POINT/$ENV_NAME."

# Keep the container running (Optional)
tail -f /dev/null
