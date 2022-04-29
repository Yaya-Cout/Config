# Get shell conf path
script_path=$(dirname $(realpath $0))
SHELLCONFPATH="$(realpath "${script_path}"/.. )"
# Source helpers script
source "${SHELLCONFPATH}/shell/helpers.sh"
# Get if used shell is zsh
if [[ "${SHELL}" = "/bin/zsh" ]]; then
  # Log that the shell is zsh
  if [[ ${DEBUG} -eq 1 ]]; then
    echo "Shell is zsh"
    echo "Sourcing zsh config"
  fi
  # Source zsh config
  source_dir "${SHELLCONFPATH}/shell/zsh"
elif [[ "${SHELL}" = "/bin/bash" ]]; then
  # Log that the shell is bash
  if [[ ${DEBUG} -eq 1 ]]; then
    echo "Shell is bash"
    echo "Sourcing bash config"
  fi
  # Source bash config
  source_dir "${SHELLCONFPATH}/shell/bash"
else
  # Shell is not zsh or bash, it is unknown
  if [[ ${DEBUG} -eq 1 ]]; then
    echo "Shell is unknown"
  fi
fi
if [[ ${DEBUG} -eq 1 ]]; then
  echo "Sourcing common config"
fi
# Source common config
source_dir "${SHELLCONFPATH}/shell/common"