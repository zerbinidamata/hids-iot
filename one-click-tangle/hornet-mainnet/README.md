# Hornet Chrysalis Node

You can also use these scripts under the [AWS Marketplace](./README_AWS.md)

## Usage

* Make the the bash script executable by running

```
chmod +x hornet.sh
```

* Install a Hornet Node connected to the Chrysalis mainnet

```
./hornet.sh install -p <peer_multiAddress> -i <docker_image>
```

The `peer_multiAddress` parameter must conform to the format specified [here](https://hornet.docs.iota.org/post_installation/peering.html)

Optionally a Docker image name can be passed, even though, by default, the image name present in the `docker-compose.yaml` file will be used, usually `gohornet/hornet:latest`. 

* Stop Hornet by running
```
./hornet.sh stop
```

* Start Hornet by running
```
./hornet.sh start
```

* Update Hornet to the latest version known at Docker Hub (`gohornet/hornet:latest`) by running
```
./hornet.sh update
```

NB: The `update` command will not update to new versions of the config files as they may contain local changes that cannot be merged with the upstream changes. If that is the case you would need to stop Hornet, merge your current config files with the config files at [https://github.com/iotaledger/one-click-tangle/blob/chrysalis/hornet-mainnet/config/config.json](https://github.com/iotaledger/one-click-tangle/blob/chrysalis/hornet-mainnet/config/config.json) and then start again Hornet. 
