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


# Get the git branch of current working directory
branch=$(git symbolic-ref --short HEAD)

# Extract the version number from branch name
version=$(echo $branch | sed 's/.*-\([0-9]\.[0-9]\.[0-9].*\)/\1/')

# Check whether the version number is valid
if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9_\.]+)*$ ]]; then
  echo "Version $version is not valid, it should be in format of 0.0.0 or 0.0.0-alpha.0 and should not contain any special characters."
  exit 1
fi

cp -r $fluid_dir history-versions/v$version
