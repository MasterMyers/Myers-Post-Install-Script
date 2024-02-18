#!/bin/bash

# This is script will clone, move and name the files I use as bash sources. It is
# currently only used for mommy-shell. It gets mommy-shell.sh and saves it as a hidden
# file in the users home dir. After that it changes the users variable in it from girl
# to boy. Lastly it adds the file as a source in .bashrc. We look though bashrc for a
# comment I use to mark manually added sources. If its there add our source right below.
# If its not there the source gets added at the end of the file.

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

# Specify the content for .bashrc
bashrc_content_1="# My manually added sources"
bashrc_content_2="# This adds the shell-mommy file to my sources. It can now always be started with mommy <command>
source ~/.shell-mommy.sh"
bashrc_content_3="$bashrc_content_1\n$bashrc_content_2"

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

# Check if bashrc_content_1 already exists in .bashrc
if ! grep -q "$bashrc_content_1" "$user_home/.bashrc"; then
  # Append the whole content to .bashrc
  echo -e "$bashrc_content_3" >> "$user_home/.bashrc"
else
  # Append only bashrc_content_2
  echo -e "$bashrc_content_2" >> "$user_home/.bashrc"
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
