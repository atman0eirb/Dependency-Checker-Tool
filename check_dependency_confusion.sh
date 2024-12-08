#!/bin/bash

# Ensure jq is installed for JSON parsing
if ! command -v jq &> /dev/null; then
  echo "Error: jq is required but not installed. Install jq and try again."
  exit 1
fi

# Check if a file argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path-to-package.json>"
  exit 1
fi

PACKAGE_JSON="$1"

# Check if the file exists
if [ ! -f "$PACKAGE_JSON" ]; then
  echo "Error: File $PACKAGE_JSON not found."
  exit 1
fi

# Extract dependencies and devDependencies
echo "Reading dependencies from $PACKAGE_JSON..."

dependencies=$(jq -r '.dependencies // {} | keys[]' "$PACKAGE_JSON")
dev_dependencies=$(jq -r '.devDependencies // {} | keys[]' "$PACKAGE_JSON")

# Combine dependencies
all_dependencies=$(echo -e "$dependencies\n$dev_dependencies")

# Function to check if a package exists on npm
check_npm_package() {
  local package_name=$1
  if curl --silent --fail "https://registry.npmjs.org/$package_name" > /dev/null; then
    echo "✅ $package_name exists on npm registry."
  else
    echo "⚠️  $package_name may be vulnerable to dependency confusion."
  fi
}

# Check each dependency
echo "Checking packages on the npm registry..."
echo "-----------------------------------------"
for package in $all_dependencies; do
  check_npm_package "$package"
done
echo "-----------------------------------------"
echo "Check completed."
