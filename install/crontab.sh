#!/usr/bin/env bash
echo "Installing crontab..."
# Get the contents of the crontab
crontab -l > /tmp/crontab.tmp
# Add the following lines to the crontab
lines="*/1 * * * * ~/Programes/check-updates.sh"
echo "${lines}" | while read -r line; do
    # If the line is already in the crontab, skip it
    if grep "${line}" /tmp/crontab.tmp; then
        echo "Skipping ${line}"
    else
        echo "Adding ${line}"
        echo "${line}" >> /tmp/crontab.tmp
    fi
done
# Install the crontab
crontab /tmp/crontab.tmp