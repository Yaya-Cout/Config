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
  else
    # Log the file
    if [[ ${DEBUG} -eq 1 ]]; then
      echo "Skipping ${file}"
    fi
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
# Get if hard link exists
function is_hard_link() {
  # Initialize function arguments
  local file=$1
  # Get if file exists
  if [[ -f ${file} ]]; then
    # Get if file is a hard link by checking if the file has more than one name
    if [[ "$(stat -c %h -- ${file})" -gt 1 ]]; then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

# Backup a file if it exists
function backup_file() {
  # Initialize function arguments
  local file=$1
  # Get if file exists
  if [[ -f ${file} ]]; then
    # Log the file
    if [[ ${DEBUG} -eq 1 ]]; then
      echo "Backing up ${file}"
    fi
    # Backup the file
    mv "${file}" "${file}.bak"
  fi
}

# Append lines from a file to another file, if some lines are already in the file, don't append them
# @param $1: The file to append to
# @param $2: The file to append from
function append_lines_to_file() {
  # Initialize function arguments
  local output_file=$1
  local input_file=$2
  # Log the function
  if [[ ${DEBUG} -eq 1 ]]; then
    echo "Importing lines from ${input_file} to ${output_file}"
    echo "Backup file: ${output_file}.bak"
  fi
  # Backup the file
  backup_file "${output_file}"
  # Get if destination file exists
  if [[ -f ${output_file} ]]; then
      # Get the lines from the output file
      output_file_lines=$(cat "${output_file}")
      # Iterate over all lines in the file using a while loop
      while read -r line; do
        # If line is not in the file, append it
        if [[ ! "${output_file_lines}" =~ "${line}" ]]; then
          echo "Appending line: ${line}"
          echo "${line}" >> "${output_file}"
        fi
      done < "${input_file}"
  fi
}