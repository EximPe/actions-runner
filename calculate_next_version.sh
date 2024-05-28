#!/bin/bash

# Extract the current version number
current_version=$(echo "$1" | cut -c 2-)

# Split the version number into parts
IFS='.' read -r -a version_parts <<< "$current_version"

# Increment the last part of the version number
((version_parts[${#version_parts[@]}-1]++))

# Join the parts back together
next_version="${version_parts[0]}"
for ((i=1; i < ${#version_parts[@]}; i++))
do
    next_version="${next_version}.${version_parts[i]}"
done

echo "$next_version"
