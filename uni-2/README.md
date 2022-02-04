# Junø - uni-2 Testnet

This testnet will start at the patched version of juno (`v2.1.0`). You will need to use the distributed binary from the juno packages repository.

## If you are reusing a testnet box, do this first

1. Stop your node
2. Reset `junod unsafe-reset-all`
3. Remove genesis `rm .juno/config/genesis.json`
4. Remove gentxs `rm -r .juno/config/gentx/`
5. If you are using cosmovisor, remove symlink: `rm .juno/cosmovisor/current`
6. Remove & recreate upgrades dir: `rm -r .juno/cosmovisor/upgrades/ && mkdir -p .juno/cosmovisor/upgrades`
7. Check genesis bin is `v2.1.0`: `$DAEMON_HOME/cosmovisor/genesis/bin/junod version`
8. Remove `seeds` and `persistent_peers` entries in `config.toml` - people will post their peer on discord before genesis
9. Follow generate gentx as normal below

Once you have deleted the old stuff, your cosmovisor should look like:

```
.juno/cosmovisor/
├── genesis
│   └── bin
│       └── junod
└── upgrades
```

**Genesis File**

[Genesis File](/uni-2/genesis.json):

```bash
   curl -s  https://raw.githubusercontent.com/CosmosContracts/testnets/main/uni-2/genesis.json > ~/.juno/config/genesis.json
```

**Genesis sha256**

```bash
sha256sum ~/.juno/config/genesis.json
# TBC
```

**junod version**

```bash
$ junod version --long
name: juno
server_name: junod
version: v2.1.0
commit: e6b8c212b178cf575035065b78309aed547b1335
build_tags: netgo muslc, # THIS BIT IS KEY
```

**Seed nodes**

```
98daa8308d2eb807e9419b98286191ab14509152@juno-uni.seed.rhinostake.com:26656
```

**Persistent Peers**

```
TBC
```

## Setup

**Prerequisites:** Make sure to have [Golang >=1.17](https://golang.org/).

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

#### Download and verify:

Note, if you're reusing a box from `uni` or `uni-1` you likely already have the correct binary. If you're using cosmovisor, you can simply follow the steps at the top of this page.

```sh
# find out where junod is - will likely be /home/<your-user>/go/bin/junod
which junod

# put new binary there i.e. in path/to/juno
wget https://github.com/CosmosContracts/juno/releases/download/v2.1.0/junod -O /home/<your-user>/go/bin/junod

# if you run this, you should see build_tags: netgo muslc,
# if there is a permissions problem use chmod/chown to make sure it is executable
junod version --long

# confirm it is using the static lib - should return "not a dynamic executable"
ldd $(which junod)

# if you really want to be sure
# this should return:
# ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, 
# Go BuildID=4Ec3fj_EKdvh_u8K3RGJ/JIKOgYFXTJ9LzGROhs8n/uC9gpeaM9MaYurh9DJiN/YcvB8Jc2ivQM2zUSHMhg, stripped
file $(which junod)
```

Check that you have the right Juno version installed:

```sh
$ junod version --long
name: juno
server_name: junod
version: v2.1.0
commit: e6b8c212b178cf575035065b78309aed547b1335
build_tags: netgo muslc, # THE MUSLC TAG IS KEY
```

### Minimum hardware requirements

- 8-16GB RAM
- 100GB of disk space
- 2 cores

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct chain-id:

```bash
junod init <moniker-name> --chain-id=uni-2
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
junod gentx <key-name> 9000000000ujunox --chain-id=uni-2
```

If all goes well, you will see a message similar to the following:

```bash
Genesis transaction written to "/home/user/.juno/config/gentx/gentx-******.json"
```

5. Change minimum gas prices in `app.toml` to `0.025ujunox`.

### Submit genesis transaction

- Fork [the testnets repo](https://github.com/CosmosContracts/testnets) into your Github account

- Clone your repo using

  ```bash
  git clone https://github.com/<your-github-username>/testnets
  ```

- Copy the generated gentx json file to `<repo_path>/uni-2/gentx/`

  ```sh
  > cd testnets
  > cp ~/.juno/config/gentx/gentx*.json ./uni-2/gentx/
  ```

- Commit and push to your repo
- Create a PR onto https://github.com/CosmosContracts/testnets
- Only PRs from individuals / groups with a history successfully running nodes will be accepted. This is to ensure the network successfully starts on time.

#### Running in production

**Note, we'll be going through some upgrades for this testnet. Consider using [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor) to make your life easier.** Setting up Cosmovisor is covered in the [Juno Documentation](https://docs.junochain.com/validators/setting-up-cosmovisor).

Download Genesis file when the time is right. Put it in your `/home/<user>/.juno` folder.

If you have not installed cosmovisor, create a systemd file for your Juno service:

```sh
sudo nano /etc/systemd/system/junod.service
```

Copy and paste the following and update `<YOUR_USERNAME>` and `<CHAIN_ID>`:

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

### Learn more

- [Cosmos Network](https://cosmos.network)
- [Juno Documentation](https://docs.junochain.com/)
