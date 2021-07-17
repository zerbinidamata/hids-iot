
`docker build -t hids_client .`

`docker run --rm -v ${pwd}:usr/src/app -it hids_client bash `

`python3 app.py --insert example.json`
