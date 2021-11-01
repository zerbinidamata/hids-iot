#!/bin/sh

# Check if Mirai controller port is being used
if lsof -nP -iTCP:48101 -sTCP:LISTEN | grep '48101'; then
  echo '{"message": "Mirai controller port found", "status": "true"}'
else
  echo '{"message": "Mirai controller port not found", "status": "false"}'
  exit 1
fi