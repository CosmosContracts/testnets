# Junø - uni-4 Testnet

This unincentivized testnet will start at juno `v9.0.0`.

The faucet will be patched to have a large sum of fake USDC, usdcx.

## If you are reusing a testnet box, do this first

1. Stop your node
2. Build `v9.0.0` tag of `junod`
3. Reset using `junod tendermint unsafe-reset-all --home ~/.juno` (the `--home` flag is required)
4. Remove genesis `rm $HOME/.juno/config/genesis.json`
5. Remove gentxs `rm -r $HOME/.juno/config/gentx/`
6. If you are using cosmovisor, remove symlink: `rm $HOME/.juno/cosmovisor/current`
7. Then remove upgrades dir `rm -r $HOME/.juno/cosmovisor/upgrades && mkdir $HOME/.juno/cosmovisor/upgrades`
8. Move `junod` to genesis bin: `cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/genesis/bin`
9. Remove any `upgrade-info` file in the `data` dir: `rm $HOME/.juno/data/upgrade-info.json`
10. Check genesis bin is `v9.0.0`: `$DAEMON_HOME/cosmovisor/genesis/bin/junod version`
11. If statesync is enabled in your config, turn it off
12. Follow generate gentx as normal below

## Setup

**Prerequisites:** Make sure to have [Golang >=1.18](https://golang.org/).

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
git checkout v9.0.0
make build && make install
```

Check that you have the right Juno version installed:

```sh
$ junod version --long
name: juno
server_name: junod
version: v9.0.0
commit: e6f9629538a88edf11aa7e7ed3d68c61f8e96aa6
build_tags: netgo,ledger
```

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct chain-id:

```bash
junod init <moniker-name> --chain-id=uni-4
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
junod gentx <key-name> 9000000000ujunox --chain-id=uni-4
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

- Copy the generated gentx json file to `<repo_path>/uni-4/gentx/`. If you want, rename it to `<your-validator-moniker>.json` so it's easier to identify.

  ```sh
  > cd testnets
  > cp "${HOME}/.juno/config/gentx/gentx*.json" ./uni-4/gentx/
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

[Genesis File](/uni-4/genesis.json):

```bash
   curl -s  https://raw.githubusercontent.com/CosmosContracts/testnets/main/uni-4/genesis.json > ~/.juno/config/genesis.json
```

**Genesis sha256**

```bash
sha256sum "${HOME}/.juno/config/genesis.json"
# 04925ba26d278e0507f66afbe93e91cc261c7ba51c0a6c5a87b1e3dd61d0b1d2
```

**junod version**

```bash
$ junod version --long
name: juno
server_name: junod
version: v9.0.0
commit: e6f9629538a88edf11aa7e7ed3d68c61f8e96aa6
build_tags: netgo,ledger
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

- [Cosmos Network](https://cosmos.network)
- [Juno Documentation](https://docs.junochain.com/)
