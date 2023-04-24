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


cd $charts_dir
# Get the git branch of current working directory
branch=$(git symbolic-ref --short HEAD)

# Extract the version number from branch name
version=$(echo $branch | sed 's/.*-\([0-9]\.[0-9]\.[0-9].*\)/\1/')

# Check whether the version number is valid
if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9_\.]+)*$ ]]; then
  echo "Version $version is not valid, it should be in format of 0.0.0 or 0.0.0-alpha.0 and should not contain any special characters."
  exit 1
fi

# Replace the version field in chart.yaml with the extracted version number
# sed -i "s/version: [0-9]\.[0-9]\.[0-9]/version: $version/g" chart.yaml
# find . -type f -name chart.yaml -exec sed -i '' "s/version: [0-9]\.[0-9]\.[0-9]/version: $version/g" {} +
find . -type f -name Chart.yaml -exec sed -i '' "s/\(version:[ ]*\)[0-9]*\.[0-9]*\.[0-9]*[-0-9A-Za-z\.]*/\1$version/g" '{}' +
