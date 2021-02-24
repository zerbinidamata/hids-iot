`docker run --rm -v ${pwd}:usr/src/app -it hids bash `

`python3 watcher.py & && python3 app.py --insert example.json`
