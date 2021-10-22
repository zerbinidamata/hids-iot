#!/bin/bash

# Check if telnet.d is running
if /etc/init.d/inetd  status | grep -q 'not running'; then
  echo '{"message": "telnet not running", "status": "false"}'

  exit 1 
else
  echo '{"message": "telnet running", "status": "true"}'
fi
