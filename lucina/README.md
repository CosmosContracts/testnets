# Juno Lucina Testnet

_Planned Start Time: June 23rd, 16:00 UTC_

**This testnet will not be incentivized.**

If you're interested in earning Juno, checkout [Hack Juno](https://github.com/CosmosContracts/hack-juno).

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

##### Building Juno

Be sure to use the latest version.

```sh
git clone https://github.com/CosmosContracts/Juno
cd Juno
starport chain build
```

### Minimum hardware requirements

- 2GB RAM
- 25GB of disk space
- 1.4 GHz amd64 CPU

The first testnet will test using SPN to deploy the chain and connect validators.

The goal is simply to get the chain started and assess the viability of using SPN.

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct
   chain-id

   ```sh
   > junod init <moniker-name> --chain-id=lucina
   ```

2. Create a local key pair

   ```sh
   > junod keys add <key-name>
   ```

3. Add your account to your local genesis file with a given amount and the key you
   just created. Use only `100000000ujuno`, other amounts will be ignored.

   ```sh
   > junod add-genesis-account $(junod keys show <key-name> -a) 100000000ujuno
   ```

4. Create the gentx

   ```sh
   > junod gentx <key-name> 90000000ujuno --chain-id=lucina
   ```

   If all goes well, you will see a message similar to the following:

   ```sh
   Genesis transaction written to "/home/user/.juno/config/gentx/gentx-******.json"
   ```

### Submit genesis transaction

- Fork [the testnets repo](https://github.com/CosmosContracts/testnets) into your Github account

- Clone your repo using

  ```sh
  > git clone https://github.com/<your-github-username>/testnets
  ```

- Copy the generated gentx json file to `<repo_path>/lucina/gentx/`

  ```sh
  > cd testnets
  > cp ~/.juno/config/gentx/gentx*.json ./lucina/gentx/
  ```

- Commit and push to your repo
- Create a PR onto https://github.com/CosmosContracts/testnets
- Only PRs from individuals / groups with a history successfully running nodes will be accepted. This is to ensure the network successfully starts on time.

#### Running in production

Download Genesis file when the time is right. Put it in your `/home/user/.juno` folder.

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
ExecStart=/home/<YOUR_USERNAME>/<GO_WORKSPACE>/go/bin/junod start --p2p.laddr tcp://0.0.0.0:26656 --home /home/<YOUR_USERNAME>/.juno
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

2
**This assumes `$HOME/go_workspace` to be your Go workspace, and `$HOME/.juno` to be your directory for config and data. Your actual directory locations may vary.**

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
