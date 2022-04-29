# Create a function to source a file if it exist
function source_if_exists() {
  # Initialize function arguments
  local file=$1
  # If file exists, source it
  if [[ -f ${file} ]]; then
    # Log the file
    if [[ ${DEBUG} -eq 1 ]]; then
      echo "Sourcing ${file}"
    fi
    # Source the file
    source "${file}"
  fi
}
# Source a directory of shell scripts recursively
function source_dir() {
  # Initialize function arguments
  local dir=$1
  # Log the directory
  if [[ ${DEBUG} -eq 1 ]]; then
    echo "Sourcing directory ${dir}"
  fi
  # Iterate over all files in the directory
  for file in "${dir}"/*; do
    # If file is a directory, recurse into it
    if [[ -d ${file} ]]; then
      # Log the directory
      if [[ ${DEBUG} -eq 1 ]]; then
        echo "Entering directory: ${file}"
      fi
      # Recurse into the directory
      source_dir "${file}"
    # Else, it is a file
    else
      # Get if file is executable
      # executable=$(test -x "${file}" && echo "1" || echo "")
      # executable=$(test -x "${file}")
      # local executable
      # If file is executable, source it
      if test -x "${file}"; then
        # Log the file
        if [[ ${DEBUG} -eq 1 ]]; then
          echo "Sourcing ${file}"
        fi
        # Source the file
        source "${file}"
      else
        # Log the file as skipped
        if [[ ${DEBUG} -eq 1 ]]; then
          echo "Skipping ${file}"
        fi
      fi
    fi
  done
}
