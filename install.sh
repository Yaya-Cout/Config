#!/usr/bin/bash
# Include helper functions
source "shell/helpers.sh"
# Get path
SHELLCONFPATH=$(pwd)
# Enable debugging
export DEBUG=1
# Configure the given rc file shell
function config_shell() {
  SHELLPATH="$1"
  # Log the shell to configure
  echo "Configuring shell: ${SHELLPATH}"
  # Setup line to write
  RCCONF="source ${SHELLCONFPATH}/shell/init.sh"
  # RCCONF="SHELLCONFPATH=${SHELLCONFPATH} source ${SHELLCONFPATH}/shell/init.sh"
  if grep -q "source ${SHELLCONFPATH}/shell/init.sh" "${SHELLPATH}"; then
    echo "Config sourcing already exists"
  else
    echo "Adding config sourcing line to rc file"
    echo "${RCCONF}" >> "${SHELLPATH}"
  fi
}
# Configure .profile
function config_profile() {
  # Get if ~/.profile exists
  if [[ -f ~/.profile ]]; then
      # Get if ~/.profile is a hard link by checking if the file has more than one name
      if is_hard_link ~/.profile; then
          echo "~/.profile is already configured"
      # Else ~/.profile isn't configured
      else
          echo "Configuring ~/.profile"
          # Backup ~/.profile
          backup_file ~/.profile
          # Hard link ~/.profile to $SHELLCONFPATH/shell/common/profile.sh
          ln "${SHELLCONFPATH}/shell/common/profile.sh" ~/.profile
      fi
  fi
}
# Configure /etc
function config_etc() {
  # Get the argument
  path_to_config=$1
  echo "Configuring ${path_to_config}"
  # Iterate over all files in ./etc
  for file in ".${path_to_config}/"*; do
    # Remove the first dot from the file name
    file_name=${file:1}
    # Get if file is a directory
    if [[ -d ${file} ]]; then
      # Call this function recursively
      echo "Entering directory: ${file_name}"
      config_etc "${file_name}"
    # Else, it is a file
    else
      # Get if file is a hard link by checking if the file has more than one name
      if is_hard_link "${file}"; then
        echo "${file_name} is already configured"
      # Else file isn't configured
      else
        echo "Configuring ${file_name} (hard link from ${file} to ${file_name})"
        # Backup file if it exists
        if [[ -f "${file_name}" ]]; then
          backup_file "${file_name}"
        fi
        # Hard link file to $SHELLCONFPATH/shell/common/etc/file
        ln "${file}" "${file_name}"
      fi
    fi
  done
}
# Handle special configs
function handle_special_configs() {
  # Handle /etc/fstab
  append_lines_to_file "/etc/fstab" "special_parsing_config/fstab"
  # Update the grub config
  echo "Updating grub config"
  update-grub
}
# If the user is not root, configure the shell
if [[ $EUID -ne 0 ]]; then
  echo "User is not root, configuring shell"
  config_shell "${HOME}/.zshrc"
  config_shell "${HOME}/.bashrc"
  config_profile
# Else, the user is root
else
  echo "User is root, configuring global configs"
  # Configure /etc
  config_etc "/etc"
  # Handle special configs
  handle_special_configs
fi
