# Uni v12 Alpha Upgrade

It's time to test Juno v12. Note that this upgrade introduces an oracle and price feeder, and these must now be run.

To install:

```sh
cd ~
git clone https://github.com/CosmosContracts/juno.git
cd ./juno/price-feeder
make install

# Copy config to your location for future use & editing
cp config.example.toml $HOME/.juno/oracle-config.toml

# If you get `cp: cannot create regular file '$HOME/.juno/oracle-config.toml': No such file or directory`, 
# run: `junod init [moniker]`. Then run the cp command again

price-feeder version # sdk: v0.45.11 and go1.19.*
# If it is not found, your go path is not set
```

Edit your juno home (~/.juno/config/app.toml) app.toml to be 0 fees for any denoms set which will take effect next restart.
minimum-gas-prices = "0ujunox"

Next, create a new price feeder account in the test keyring. This account will need to be sent 1 JUNOX _(1000000ujunox)_. This can be done before or after the upgrade takes place

junod keys add feeder --keyring-backend test
junod tx bank send <validator> <feeder-address> 1000000ujunox --chain-id uni-5 --fees 500ujunox

Update the oracle config in `$HOME/.juno/oracle-config.toml`

    nano $HOME/.juno/oracle-config.toml

Set the gas_price to `0ujunox`. Then set the address you created (feeder address) and validator (valoper address). Once the chain is back online you must to do the following:

junod tx bank send <validator_key> <feeder_addr> 1000000ujunox  --chain-id uni-5 --fees 500ujunox
&
junod tx oracle set-feeder <feeder_addr> --from <validator_key>  --chain-id uni-5 --fees 500ujunox

You can do this configuration using sed, if you're into that:

```sh
FEEDER_ADDR=<feeder-addr>
VALOPER_ADDR=<your-valoper-address>
CHAIN_ID=uni-5
sed -i \
 's/0.0001stake/0ujunox/g;
 s/address = "juno1w20tfhnehc33rgtm9tg8gdtea0svn7twfnyqee"/address = "'"$FEEDER_ADDR"'"/g;
 s/validator = "junovaloper1w20tfhnehc33rgtm9tg8gdtea0svn7twkwj0zq"/validator = "'"$VALOPER_ADDR"'"/g;
 s/chain_id = "test-1"/chain_id = "'"$CHAIN_ID"'"/g;
 s/"chain_id", "test-1"/"chain_id", "'"$CHAIN_ID"'"/g' \
$HOME/.juno/oracle-config.toml
```

Create a service file for the oracle:

    sudo nano /etc/systemd/system/oracle.service

Here's the config:

```
[Unit]
Description=juno-price-feeder
After=network.target

[Service]
Type=simple
User=<your-user>
ExecStart=$HOME/go/bin/price-feeder $HOME/.juno/oracle-config.toml --log-level debug
Restart=on-abort
LimitNOFILE=65535
Environment="PRICE_FEEDER_PASS=anything"

[Install]
WantedBy=multi-user.target
```

The price feeder pass can be set to anything if you're using keyring test in the config file.

Enable like so:

```sh
sudo systemctl daemon-reload
sudo systemctl enable oracle
sudo systemctl start oracle
```

If you've not voted yet, please vote:

    junod tx gov vote 31 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-5 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v12.0.0-alpha).

The Upgrade is scheduled for block `1785500`, which should be about _1700 UTC on Friday 20th January_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/1785500).

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git fetch --tags
git checkout v12.0.0-alpha
make build && make install

# check the version - should be v12.0.0-alpha
# junod version --long will be commit 0e77692cb1cec195b1ebf986c45367fa02c39c20
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v12/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v12/bin

# find out what version you are about to run - should be v12.0.0-alpha
$DAEMON_HOME/cosmovisor/upgrades/v12/bin/junod version
```
