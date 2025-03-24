# Junø - uni-7 Testnet

This unincentivized testnet will start at juno `v27.0.0`.

The faucet will be patched to have a large sum of fake USDC, usdcx.

## Setup

**Prerequisites:** Make sure to have [Golang >=1.22](https://golang.org/).

### Minimum hardware requirements

- 8-16GB RAM
- 200GB of disk space
- 2 cores

#### Go setup

You need to ensure your gopath configuration is correct. If the following **'make'** step does not work then you might have to add these lines to your .profile or .zshrc in the users home folder:

```sh
nano ~/.profile
```

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```

Source update .profile

```sh
source .profile
```

#### Download Juno

```sh
git clone https://github.com/CosmosContracts/juno
cd juno
git checkout v27.0.0
make build && make install
```

Check that you have the right Juno version installed:

```sh
$ junod version --long
build_tags: netgo,ledger
commit: 82743697f47dcda173537be27e5b6220ca758141
cosmos_sdk_version: v0.47.15
go: go version go1.22.2 darwin/arm64
name: juno
server_name: junod
version: v27.0.0
```

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct chain-id:

```bash
junod init <moniker-name> --chain-id=uni-7
```

2. Create a local key pair (skip this step if you already have a key):

```sh
> junod keys add <key-name>
```

3. Add your account to your local genesis file with a given amount and the key you just created. Use only `10000000000ujunox`, other amounts will be ignored.

```bash
junod add-genesis-account $(junod keys show <key-name> -a) 10000000000ujunox
```

4. Create the gentx, use only `9000000000ujunox`:

```bash
junod gentx <key-name> 9000000000ujunox --chain-id=uni-6
```

If all goes well, you will see a message similar to the following:

```bash
Genesis transaction written to "${HOME}/.juno/config/gentx/gentx-******.json"
```

5. Change minimum gas prices in `app.toml` to `0.0025ujunox`.

### Submit genesis transaction

- Fork [the testnets repo](https://github.com/CosmosContracts/testnets) into your Github account

- Clone your repo using

  ```bash
  git clone https://github.com/<your-github-username>/testnets
  ```

- Copy the generated gentx json file to `<repo_path>/uni-7/gentx/`. If you want, rename it to `<your-validator-moniker>.json` so it's easier to identify.

  ```sh
  > cd testnets
  > cp "${HOME}/.juno/config/gentx/gentx*.json" ./uni-7/gentx/
  ```

- Commit and push to your repo
- Create a PR onto https://github.com/CosmosContracts/testnets
- Only PRs from individuals / groups with a history successfully running nodes will be accepted. This is to ensure the network successfully starts on time.

#### Running in production

**Note, as usual we'll be going through some upgrades for this testnet. Consider using [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor) to make your life easier.** Setting up Cosmovisor is covered in the [Juno Documentation](https://docs.junochain.com/validators/setting-up-cosmovisor).

Download Genesis file when the time is right. Put it in your `${HOME}/.juno` folder.

If you have not installed cosmovisor, create a systemd file for your Juno service:

```sh
sudo nano /etc/systemd/system/junod.service
```

Copy and paste the following and update `<YOUR_USERNAME>`:

```sh
Description=Juno daemon
After=network-online.target

[Service]
User=juno
ExecStart=/home/<YOUR_USERNAME>/go/bin/junod start
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

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

## Once the Genesis has been Generated.

**Genesis File**

[Genesis File](/uni-7/genesis.zip):

```bash
   curl -s  https://raw.githubusercontent.com/CosmosContracts/testnets/main/uni-6/genesis.zip > ~/.juno/config/genesis.zip
   cd ~/.juno/config/
   unzip genesis.zip
   rm genesis.zip
```

**Genesis sha256**

```bash
sha256sum "${HOME}/.juno/config/genesis.json"
# <todo>
```

**junod version**

```bash
$ junod version --long
build_tags: netgo,ledger
commit: 82743697f47dcda173537be27e5b6220ca758141
cosmos_sdk_version: v0.47.15
go: go version go1.22.2 darwin/arm64
name: juno
server_name: junod
version: v27.0.0
```

**Seed nodes**

```
TBD
```

**Persistent Peers**

```
TBC
```

### Learn more

- [Juno Documentation](https://docs.junonetwork.io/)
