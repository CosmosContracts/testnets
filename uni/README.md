# Junø - Uni Testnet

_Planned Start Time: October 15th at 4 PM UTC._

Please have your gentx submitted by Thursday, October 14th, 6pm UTC if you wish to participate.

**This testnet will not be incentivized.**

If you're interested in earning Juno, checkout [Hack Juno](https://github.com/CosmosContracts/hack-juno) or consider running a [mainnet validator](https://docs.junochain.com/validators/joining-mainnet).

The plan for this test will be to practice a simulated upgrade as well as test the latest Juno binary (which will include the latest CosmWasm). As such, we will start the testnet with the same `v1.0.0` version as mainnet.

**Genesis File**

[Genesis File](/uni/genesis.json):

```bash
   curl -s  https://raw.githubusercontent.com/CosmosContracts/testnets/main/uni/genesis.json >~/.juno/config/genesis.json
```

**Genesis sha256**

```bash
sha256sum ~/.juno/config/genesis.json
e3101bbd7bad8976fbb28b7c6f18c134198b4c672a9e7fba009332132d45235f
```

**junod version**

```bash
$ junod version --long
name: juno
server_name: junod
version: HEAD-e507450f2e20aa4017e046bd24a7d8f1d3ca437a
commit: e507450f2e20aa4017e046bd24a7d8f1d3ca437a
```

**Seed nodes**

[Full seed nodes list](/uni/seeds.txt).

```
17b42def9d3a43a030a5a2824dd7344fc2bc70ba@35.209.191.98:26656,ee6ed9bdd7d61e6521e8711626b32084f2ee5be6@159.203.161.68:26656
```

## Setup

**Prerequisites:** Make sure to have [Golang >=1.17](https://golang.org/).

#### Build from source

You need to ensure your gopath configuration is correct. If the following **'make'** step does not work then you might have to add these lines to your .profile or .zshrc in the users home folder:

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
```

```sh
git clone https://github.com/CosmosContracts/juno
cd juno
git checkout v1.0.0
make build && make install
```

This will build and install `junod` binary into `$GOBIN`.

Note: When building from source, it is important to have your `$GOPATH` set correctly. When in doubt, the following should do:

```sh
mkdir ~/go
export GOPATH=~/go
```

Check that you have the right Juno version installed:

```sh
$ junod version --long
name: juno
server_name: junod
version: HEAD-e507450f2e20aa4017e046bd24a7d8f1d3ca437a
commit: e507450f2e20aa4017e046bd24a7d8f1d3ca437a
```

### Minimum hardware requirements

- 2GB RAM
- 100GB of disk space
- 1.4 GHz amd64 CPU

## Setup validator node

Below are the instructions to generate & submit your genesis transaction

### Generate genesis transaction (gentx)

1. Initialize the Juno directories and create the local genesis file with the correct chain-id:

   ```bash
   junod init <moniker-name> --chain-id=uni
   ```

2. Create a local key pair:

   ```sh
   > junod keys add <key-name>
   ```

3. Add your account to your local genesis file with a given amount and the key you just created. Use only `10000000000ujunox`, other amounts will be ignored.

   ```bash
   junod add-genesis-account $(junod keys show <key-name> -a) 10000000000ujunox
   ```

4. Create the gentx, use only `9000000000ujunox`:

   ```bash
   junod gentx <key-name> 9000000000ujunox --chain-id=uni
   ```

   If all goes well, you will see a message similar to the following:

   ```bash
   Genesis transaction written to "/home/user/.juno/config/gentx/gentx-******.json"
   ```

### Submit genesis transaction

- Fork [the testnets repo](https://github.com/CosmosContracts/testnets) into your Github account

- Clone your repo using

  ```bash
  git clone https://github.com/<your-github-username>/testnets
  ```

- Copy the generated gentx json file to `<repo_path>/uni/gentx/`

  ```sh
  > cd testnets
  > cp ~/.juno/config/gentx/gentx*.json ./uni/gentx/
  ```

- Commit and push to your repo
- Create a PR onto https://github.com/CosmosContracts/testnets
- Only PRs from individuals / groups with a history successfully running nodes will be accepted. This is to ensure the network successfully starts on time.

#### Running in production

**Note, we'll be going through some upgrades for this testnet. Consider using [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/master/cosmovisor) to make your life easier.** Setting up Cosmovisor is covered in the [Juno Documentation](https://docs.junochain.com/validators/setting-up-cosmovisor).

Download Genesis file when the time is right. Put it in your `/home/<user>/.juno` folder.

Create a systemd file for your Juno service:

```sh
sudo nano /etc/systemd/system/junod.service
```

Copy and paste the following and update `<YOUR_USERNAME>` and `<CHAIN_ID>`:

```sh
Description=Juno daemon
After=network-online.target

[Service]
User=juno
ExecStart=/home/<YOUR_USERNAME>/go/bin/junod start --p2p.laddr tcp://0.0.0.0:26656 --home /home/<YOUR_USERNAME>/.juno
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

2
**This assumes `$HOME/go` to be your Go workspace, and `$HOME/.juno` to be your directory for config and data. Your actual directory locations may vary.**

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
- [Cosmos Community Discord](https://discord.com/invite/W8trcGV) (check out the #starport channel)
- [Juno Documentation](https://docs.junochain.com/)
