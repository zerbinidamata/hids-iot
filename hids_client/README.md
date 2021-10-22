
`docker build -t hids_client .`

`docker run --rm -v ~/hids-iot/hids_client:/usr/src/app --network=hids_iot_network -it hids_client bash`

`python3 app.py --insert example.json`


docker run --rm --name hids_client_1 ${pwd}:usr/src/app hids_client  


docker run --rm --name hids_client_2 ${pwd}:usr/src/app hids_client  


docker run --rm --name hids_client_3 ${pwd}:usr/src/app hids_client  