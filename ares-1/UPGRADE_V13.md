# Ares v13 Upgrade (Part 1)

If you've not voted yet, please vote:

    junod tx gov vote 1 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id ares-1 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v13.0.0-beta.1).

The Upgrade is scheduled for block `4301`.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash

# get the new version
git fetch --tags
git checkout v13.0.0-beta
make build && make install

# check the version - should be v13.0.0-beta
# junod version --long will be commit a3f41b74b39ae9326962bf183d699081d2840f76
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v13-1/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v13-1/bin

# find out what version you are about to run - should be v13.0.0-beta
$DAEMON_HOME/cosmovisor/upgrades/v13-1/bin/junod version

```
