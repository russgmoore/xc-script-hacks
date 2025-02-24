#!/bin/bash

# Directory containing the YAML files
input_dir="yaml_output"

# Command template
command_template="/home/russg/ves/vesctl.linux-amd64 request rpc user.CustomAPI.Create -i YAML --uri /public/custom/namespaces/system/user_roles --http-method POST"

# Verify input directory exists
if [ ! -d "$input_dir" ]; then
  echo "Error: Directory $input_dir does not exist."
  exit 1
fi

# Iterate over all YAML files in the directory
for yaml_file in "$input_dir"/*.yaml; do
  # Skip if no YAML files are found
  [ -e "$yaml_file" ] || { echo "No YAML files found in $input_dir"; break; }

  # Replace YAML placeholder with the current file
  command="${command_template//YAML/$yaml_file}"

  # Run the command
  echo "Executing: $command"
  eval "$command"
  sleep 1

  # Check if the command was successful
  if [ $? -ne 0 ]; then
    echo "Error: Command failed for $yaml_file"
    exit 1
  fi
done

echo "All commands executed successfully."
