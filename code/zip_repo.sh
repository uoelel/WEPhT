#!/bin/bash

# Define the folder path
folder_path="./"

# Define the output zip file name
output_zip="./wepht.zip"

# Navigate to the folder
cd "$folder_path" || exit

# Create a temporary directory for the files to be zipped
tmp_dir=$(mktemp -d)

# Copy all files and folders to the temporary directory excluding .git, .gitignore, and code folder
rsync -av --exclude='.git' --exclude='.gitignore' --exclude='code' --exclude='data/swahili/swah1253' --exclude='data/swahili/swah1253_vowels' --exclude='data/swahili/fricatives.csv'  ./ "$tmp_dir"

# Navigate back to the original directory
cd - || exit

# Create the zip file
zip -r "$output_zip" "$tmp_dir"

# Clean up temporary directory
rm -r "$tmp_dir"

echo "Zip file created: $output_zip"
