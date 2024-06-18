#!/bin/bash

# We deploy to the 'default' machine, if you have more machines, replace the machine name here.
machine_name="docker-apache"

# Check if the VM is running
VBoxManage list runningvms | grep -q "\"$machine_name\""
if [ $? -eq 0 ]; then
  VBoxManage controlvm "$machine_name" poweroff
else
  echo "VM is not running"
fi
