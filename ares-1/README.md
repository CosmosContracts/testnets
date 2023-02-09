# Junø - ares-1 Testnet

This unincentivized testnet will start at the v12 version of juno, `v12.0.0-beta.1`

Once the genesis network is up and running, we'll test the v13 upgrade to `v13.0.0-beta` to test part 1 of the upgrade

## If you are reusing an old testnet box, do this first

NOTE: do not do this on a mainnet or Uni node currently running...

1. Stop your node
2. Reset `junod unsafe-reset-all`
3. Remove genesis `rm .juno/config/genesis.json`
4. Remove gentxs `rm -r .juno/config/gentx/`
5. If you are using cosmovisor, remove symlink: `rm .juno/cosmovisor/current`
6. Check genesis bin is `v12.0.0-beta.1`: `$DAEMON_HOME/cosmovisor/genesis/bin/junod version`
7. Follow generate gentx as normal below

## Setup

**Prerequisites:** Make sure to have [Golang >=1.19](https://golang.org/).

### Minimum hardware requirements

- 8-16GB RAM
- 100GB of disk space
- 2 cores

#### Go setup

You need to ensure your gopath configuration is correct. If the following **'make'** step does not work then you might have to add these lines to your .profile or .zshrc in the users home folder:

```sh
nano ~/.profile
```

```bash
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
git checkout v12.0.0-beta.1
make build && make install
```

Check that you have the right Juno version installed:

```sh
$ junod version --long
name: juno
server_name: junod
version: v12.0.0-beta.1
commit: c2aa971c72afcac13fa09e622db40853f5c86f24
build_tags: netgo,ledger
```

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct chain-id:

```bash
junod init <moniker-name> --chain-id=ares-1
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
junod gentx <key-name> 9000000000ujunox --chain-id=ares-1
```

If all goes well, you will see a message similar to the following:

```bash
Genesis transaction written to "${HOME}/.juno/config/gentx/gentx-******.json"
```

5. Change minimum gas prices in `app.toml` to `0.025ujunox`.

### Submit genesis transaction

- Send your gentx in the discord group

  ```sh
  > cat ${HOME}/.juno/config/gentx/gentx*.json
  ```

- Send your peer in the discord group

  ```sh
  > junod tendermint show-node-id
  ```

  `ex: 9b5c23ca17129d17891d4bd22cca8fa2f20a8de3@135.181.85.92:26656`

---

#### Running in production

**Note, we'll be going through some upgrades for this testnet. Consider using [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor) to make your life easier.** Setting up Cosmovisor is covered in the [Juno Documentation](https://docs.junochain.com/validators/setting-up-cosmovisor).

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

## Once the Genesis has been Generated

TBD

<!-- **Genesis File**

[Genesis File](/ares-1/genesis.json):

```bash
   curl -s  https://raw.githubusercontent.com/CosmosContracts/testnets/main/ares-1/genesis.json > ~/.juno/config/genesis.json
```

**Genesis sha256**

```bash
sha256sum "${HOME}/.juno/config/genesis.json"
# TBD
```

**junod version**

```bash
$ junod version --long
name: juno
server_name: junod
version: v4.0.0
commit: 299fe4bdee7a7a8b45cd2776359243fdf3630e5a
build_tags: netgo,ledger
``` -->

**Seed nodes**

```
TBD
```

**Persistent Peers**

```
TBD
```

### Learn more

- [Cosmos Network](https://cosmos.network)
- [Juno Documentation](https://docs.junochain.com/)
