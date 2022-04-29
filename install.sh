#!/usr/bin/bash
# Get path
SHELLCONFPATH=$(pwd)
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
config_shell "${HOME}/.zshrc"
config_shell "${HOME}/.bashrc"
# Get if ~/.profile exists
if [[ -f ~/.profile ]]; then
    # Get if ~/.profile is a hard link by checking if the file has more than one name
    if [[ "$(stat -c %h -- ~/.profile)" -gt 1 ]]; then
        echo "~/.profile is already configured"
    # Else ~/.profile isn't configured
    else
        echo "Configuring ~/.profile"
        # Backup ~/.profile
        mv ~/.profile ~/.profile.bak
        # Hard link ~/.profile to $SHELLCONFPATH/shell/common/profile.sh
        ln "${SHELLCONFPATH}/shell/common/profile.sh" ~/.profile
    fi
fi