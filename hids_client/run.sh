# Run HIDS client
crond -f &
python3 logWatcher.py & 
cd /home/hids_client 
python3 app.py --insert example.json
