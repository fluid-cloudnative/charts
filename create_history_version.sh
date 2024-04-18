#!/bin/bash

set -e # Set to stop execution on error

charts_dir="charts"
fluid_dir="$charts_dir/fluid"
fluid_source_dir="../fluid/$charts_dir/fluid"
history_dir="history-versions"

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

# Get the git branch of current working directory
branch=$(git symbolic-ref --short HEAD)

# Extract the version number from branch name
version=$(echo $branch | sed 's/.*-\([0-9]\.[0-9]\.[0-9].*\)/\1/')

# Check if there is no version number in branch name
if [ -z "$version" ]; then
  echo "Error: No version number found in branch name."
  exit 1
fi

# Check whether the version number is valid
if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9_\.]+)?$ ]]; then
  echo "Version $version is not valid, it should be in format of 0.0.0 or 0.0.0-alpha.0 and should not contain any special characters."
  exit 1
fi

# Check if the historical directory exists, if not, create it.
if [ ! -d "$history_dir" ]; then
  mkdir -p $history_dir
fi

# If --force option is used, remove any existing directory. Otherwise, stop the operation.
if [ "$1" == "--force" ]; then
  if [ -d "$history_dir/v$version" ]; then
    echo "Warning: Directory $history_dir/v$version already exists, it will be removed due to the --force option."
    rm -rf $history_dir/v$version
  fi
else
  if [ -d "$history_dir/v$version" ]; then
    echo "Error: Directory $history_dir/v$version already exists. Use the --force option to overwrite it."
    exit 1
  fi
fi

# Copy files
cp -r $fluid_dir $history_dir/v$version
echo "Copied fluid directory to $history_dir/v$version."
