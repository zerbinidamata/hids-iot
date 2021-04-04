#!/bin/bash

# Check if sshd is running
if /etc/init.d/ssh status | grep -q 'not running'; then
  echo "sshd not running"
  exit 1 
else
  echo "sshd running"
fi
