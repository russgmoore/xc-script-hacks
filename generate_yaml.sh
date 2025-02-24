#!/bin/bash

# Input CSV file
input_file="users.csv"

# Output path for YAML files
output_dir="yaml_output"
mkdir -p "$output_dir"

# Template for YAML file
template="---
email: EMAIL_PLACEHOLDER
idmType: VOLTERRA_MANAGED
first_name: FIRST_PLACEHOLDER
last_name: LAST_PLACEHOLDER
group_names:
- amer
- managed-monitor
- partner-monitor
- partner-was
- appworld2025
- was-monitor
"

# Skip the header if your CSV has one
# Read line by line
while IFS=, read -r first last email; do
  # Skip empty lines
  [ -z "$first" ] && continue

  # Replace placeholders in the template
  yaml_content="${template//EMAIL_PLACEHOLDER/$email}"
  yaml_content="${yaml_content//FIRST_PLACEHOLDER/$first}"
  yaml_content="${yaml_content//LAST_PLACEHOLDER/$last}"

  # Create file name based on user's email (removing special characters)
  yaml_filename="${email//[^a-zA-Z0-9]/_}.yaml"

  # Save to file
  echo "$yaml_content" > "$output_dir/$yaml_filename"
  echo "Generated: $output_dir/$yaml_filename"

done < <(tail -n +2 "$input_file")  # Skip header row
