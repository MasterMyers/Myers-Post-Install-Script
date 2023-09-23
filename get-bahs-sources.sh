#!/bin/bash

# Set the URL of the Git repository you want to clone
repo_url="https://github.com/sudofox/shell-mommy.git"

# Get the current user's home directory using the HOME environment variable
user_home="$HOME"

# Specify the directory name for the clone (you can change this as needed)
clone_dir_name="shell-mommy"

# Construct the full path to the destination directory
clone_dir="$user_home/$clone_dir_name"

# Specify the file to move and rename
file_to_move="shell-mommy.sh"
new_file_name=".shell-mommy.sh"

# Specify the content to add to the end of the .bashrc file
bashrc_content="# My manually added sources
# This adds the shell-mommy file to my sources. It can now always be started with mommy <command>
source ~/.shell-mommy.sh"

# Check if the destination directory already exists
if [ -d "$clone_dir" ]; then
  echo "Destination directory already exists. Aborting."
  exit 1
fi

# Clone the Git repository
git clone "$repo_url" "$clone_dir"

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "Repository cloned successfully to: $clone_dir"
else
  echo "Failed to clone the repository."
  exit 1
fi

# Move the file from the clone directory to the user's home directory and rename it
mv "$clone_dir/$file_to_move" "$user_home/$new_file_name"

# Check if the move was successful
if [ $? -eq 0 ]; then
  echo "File moved and renamed successfully to: $user_home/$new_file_name"
else
  echo "Failed to move and rename the file."
fi

# Modify the moved file to change DEF_WORDS_LITTLE="girl" to DEF_WORDS_LITTLE="boy"
sed -i 's/DEF_WORDS_LITTLE="girl"/DEF_WORDS_LITTLE="boy"/' "$user_home/$new_file_name"

# Check if the sed operation was successful
if [ $? -eq 0 ]; then
  echo "File modified successfully."
else
  echo "Failed to modify the file."
  exit 1
fi

# Check if "# My manually added sources" already exists in .bashrc
if grep -q "# My manually added sources" "$user_home/.bashrc"; then
  # Append content below the existing line
  awk -v text="$bashrc_content" '/# My manually added sources/{print; print text; next}1' "$user_home/.bashrc" > temp && mv temp "$user_home/.bashrc"
else
  # Append the whole content to the end of .bashrc
  echo "$bashrc_content" >> "$user_home/.bashrc"
fi

# Check if the addition to .bashrc was successful
if [ $? -eq 0 ]; then
  echo "Content added to .bashrc successfully."
else
  echo "Failed to add content to .bashrc."
  exit 1
fi

# Delete the clone directory
rm -r "$clone_dir"

# Check if the deletion was successful
if [ $? -eq 0 ]; then
  echo "Clone directory deleted successfully."
else
  echo "Failed to delete the clone directory."
fi