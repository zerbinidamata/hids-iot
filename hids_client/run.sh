# Run HIDS client
crond -f &
python3 logWatcher.py & 
python3 app.py --insert example.json
