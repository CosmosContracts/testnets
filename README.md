# Juno Testnets

- [Testnet 1](#testnet-1)

## Setup

You will need [Starport](https://github.com/tendermint/starport) installed. We'll be using SPN to deploy the chain and connect validators. [SPN](https://github.com/tendermint/spn) is being actively developed, please, build Starport from source and use the latest `develop` branch.

### Install and build latest Starport:

**Prerequisites:** If you want to install Starport locally, make sure to have [Golang >=1.16](https://golang.org/). The latest version of Starport also requires [Protocol Buffer compiler](https://grpc.io/docs/protoc-installation/) to be installed. [Node.js >=12.19.0](https://nodejs.org/) is used to build the welcome screen, block explorer and to run the web scaffold.

#### Build from source

Starport uses [Git LFS](https://git-lfs.github.com/). **Please make sure that it is installed before cloning Starport.**

If you have installed Git LFS after cloning Starport, checkout to your preferred branch to trigger a pull for large files or run `git lfs pull`.

You need to ensure your gopath configuration is correct. If the following **'make'** step does not work then you might have to add these lines to your .profile or .zshrc in the users home folder:
```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```


```sh
git clone https://github.com/tendermint/starport
cd starport && git checkout develop
make
```

This will build and install `starport` binary into `$GOBIN`.

Note: When building from source, it is important to have your `$GOPATH` set correctly. When in doubt, the following should do:

```sh
mkdir ~/go
export GOPATH=~/go
```

### Minimum hardware requirements

- 2GB RAM
- 25GB of disk space
- 1.4 GHz CPU

## Testnet 1

The first testnet will test using SPN to deploy the chain and connect validators.

The goal is simply to get the chain started and assess the viability of using SPN.

### Parameters

- `chainID`: `juno-testnet-3`
- _Start time: April 25th, 16:00UTC_

### Joining as a validator

**IMPORTANT: Be sure to run the following on the machine you'll use for the testnet.**

Run the following command from a server to propose yourself as a validator:

```
starport network chain join [chainID] --nightly
```

Follow the prompts to provide information about the validator. Starport will download the source code of the blockchain node, build, initialize and create and send two proposals to SPN: to add an account and to add a validator with self-delegation. By running a `join` command you act as a "validator". When filling out the required parameters ensure to include the **'stake'** word after the required values for the inputs to be accepted. If the terminal gets an error or hangs then you can also try: `starport network chain join [chainID] --nightly --keyring-backend "test"`

Be sure to write down your seed phrase, you'll need to add your key to junod to interact with the chain.

#### Starting your blockchain node

Run the following command to start your blockchain node:

```
starport network chain start [chainID] --nightly
```

This command will use SPN to create a correct genesis file, configure and launch your blockchain node. Once the node is started and the required number of validators are online, you will see output with incrementing block height number, which means that the blockchain has been successfully started.

#### Running in production

Create a systemd file for your Juno service:

```sh
sudo vi /etc/systemd/system/junod.service
```

Copy and paste the following and update `<YOUR_USERNAME>`, `<GO_WORKSPACE>`, and `<CHAIN_ID>`:

```sh
Description=Juno daemon
After=network-online.target

[Service]
User=root
ExecStart=/home/<YOUR_USERNAME>/<GO_WORKSPACE>/go/bin/junod start --p2p.laddr tcp://0.0.0.0:26656 --home /home/<YOUR_USERNAME>/.spn-chain-homes/<CHAIN_ID>
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

2
**This assumes `$HOME/go_workspace` to be your Go workspace. Your actual workspace directory may vary.**

Enable and start the new service:

```sh
sudo systemctl enable junod
sudo systemctl start junod
```

Check status:

```sh
junod status
```

Check logs:

```sh
journalctl -u junod -f
```

### Learn more

- [Starport](https://github.com/tendermint/starport)
- [SPN](https://github.com/tendermint/spn)
- [Cosmos Network](https://cosmos.network)
- [Cosmos Community Discord](https://discord.com/invite/W8trcGV) (check out the #starport channel)
