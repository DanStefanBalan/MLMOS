#!/bin/bash

log_file="/var/log/system-bootstrap.log"

echo "$(date) Starting Bootstrap.sh" >> "$log_file"

# system packages
if [[ $1 -eq 0 ]]; then
  yum -y update &&
  echo "$(date) The packages were updated successfully." >> "$log_file"
#checking the exit status of update command
  if [[ "$?" -eq 1 ]]; then
    echo "$(date) The packages failed to update" >> "$log_file"
  fi
fi

# selinux config
sed -i 's/SETENFORCE=[a-z]*/SETENFORCE=disabled/g' /etc/selinux/config &&
echo "$(date) SETENFORCE successfully set to 'disabled'." >> "$log_file"

#checking the exit status of setenforce command
if [[ "$?" -eq 0 ]]; then
  setenforce 0 &&
  echo "$(date) SETENFORCE successfully set to '0'." >> "$log_file"

  elif [[ "$?" -eq 1 ]]; then
    echo "$(date) Failed to set SETENFORCE to 'disabled'." >> "$log_file"
fi

echo "$(date) Bootstrap finished" >> "$log_file" 
