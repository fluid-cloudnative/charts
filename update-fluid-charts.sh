#!/bin/bash

#!/bin/bash

set -e # Set to stop execution on error

# Ensure the current directory is the 'charts' directory
if [ "$(basename $(pwd))" != "charts" ]; then
  echo "Error: The script should be executed in the 'charts' directory."
  exit 1
fi

# Ensure the current directory contains the 'charts' subdirectory
if [ ! -d "charts" ]; then
  echo "Error: The 'charts' directory does not exist in the current directory."
  exit 1
fi

# Check if the 'fluid' directory exists under the 'charts' directory
if [ -d "charts/fluid" ]; then
  # Remove the 'fluid' directory under the 'charts' directory
  rm -rf charts/fluid
fi

# Copy the 'fluid' directory in the current directory to the 'charts' directory
cp ../fluid/charts/fluid/fluid charts
