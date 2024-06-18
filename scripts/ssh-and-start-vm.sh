#!/bin/bash

# We deploy to the 'default' machine, if you have more machines, replace the machine name here.
machine_name="docker-apache"
guest_machine_ip=$(VBoxManage guestproperty get "$machine_name" "/VirtualBox/GuestInfo/Net/1/V4/IP" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
username="vagrant" # Default vagrant username
private_key="./.vagrant/machines/$machine_name/virtualbox/private_key" # SSH private key location

# Check if the VM is running
VBoxManage list runningvms | grep -q "\"$machine_name\""
if [ $? -eq 0 ]; then
  echo "VM is running"
else
  echo "VM is not running"
  VBoxManage startvm "$machine_name" --type headless
fi

# Wait for the VM to be fully booted
while true; do
  logged_in_users=$(VBoxManage guestproperty get "$machine_name" "/VirtualBox/GuestInfo/OS/LoggedInUsers")
  if echo "$logged_in_users" | grep -q "0" || echo "$logged_in_users" | grep -q "1"; then
    echo "VM is fully booted"
    break
  else
    echo "Waiting for VM to boot..."
    sleep 5
  fi
done

ssh -i "$private_key" "$username@$guest_machine_ip"