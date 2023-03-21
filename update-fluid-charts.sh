#!/bin/bash

set -ex # Set to stop execution on error

charts_dir="charts"
fluid_dir="$charts_dir/fluid"
fluid_source_dir="../fluid/$charts_dir/fluid"

# Ensure the current directory is the 'charts' directory
if [ "$(basename $(pwd))" != "$charts_dir" ]; then
  echo "Error: The script should be executed in the 'charts' directory."
  exit 1
fi

# Ensure the current directory contains the 'charts' subdirectory
if [ ! -d "$charts_dir" ]; then
  echo "Error: The 'charts' directory does not exist in the current directory."
  exit 1
fi

# Check if the 'fluid' directory exists under the 'charts' directory
if [ -d "$fluid_dir" ]; then
  # Remove the 'fluid' directory under the 'charts' directory
  rm -rf "$fluid_dir"
fi

# Copy the 'fluid' directory in the current directory to the 'charts' directory
cp -r "$fluid_source_dir/fluid" "$charts_dir"
