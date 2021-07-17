#!/bin/bash

# Check if sshd is running
if /etc/init.d/ssh status | grep -q 'not running'; then
  echo '{"message": "sshd not running", "status": "false", "code": 1}'

  exit 1 
else
  echo '{"message": "sshd running", "status": "true"}'
fi
