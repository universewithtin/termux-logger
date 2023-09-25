#!/bin/bash

# Run termux-info and extract the device model
device_model=$(getprop ro.product.model)

# Run termux-battery-status and extract the percentage and current
battery_info=$(termux-battery-status | grep -E "percentage|current" | awk '{print $2}')

# Get the current date and time
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Prepare the content to be written to the file
content="$current_time,$device_model,$battery_info"

# Generate the filename based on the device model
filename="${device_model// /_}.csv"

# Check if CSV is supported
if hash csvformat 2>/dev/null; then
  # Write to a CSV file
  echo "$content" | csvformat -D ',' >> "$filename"
else
  # Write to a TXT file
  echo "$content" >> "$filename"
fi

termux-toast -g Data written to $filename

