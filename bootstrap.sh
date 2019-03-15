#!/bin/bash

log_file="/var/log/system-bootstrap.log"

echo "$(date) [INIT] BOOTSTRAP.SH" >> "$log_file"

# update system packages
if [[ $1 -eq 0 ]]; then
  yum -y update &&
  echo "$(date) Packages updated successfully." >> "$log_file"

  if [[ "$?" -eq 1 ]]; then
    echo "$(date) Failed to update packages." >> "$log_file"
  fi
fi

# selinux config
sed -i 's/SETENFORCE=[a-z]*/SETENFORCE=disabled/g' /etc/selinux/config &&
echo "$(date) SETENFORCE successfully set to 'disabled'." >> "$log_file"

if [[ "$?" -eq 0 ]]; then
  setenforce 0 &&
  echo "$(date) SETENFORCE successfully set to '0'." >> "$log_file"

  elif [[ "$?" -eq 1 ]]; then
    echo "$(date) Failed to set SETENFORCE to 'disabled'." >> "$log_file"
fi

echo "$(date) Bootstrap finished" >> "$log_file" 
echo "$(date) Bootstrap results are available in the $log_file file."