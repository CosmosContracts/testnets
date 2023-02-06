# Uni v12 Beta Upgrade

We've tagged a different release candidate for v12 (make sure you don't use `-alpha`) so that we can progress some changes to mainnet while we selectively test all the original slated v12 features as Juno v13.

If you've not voted yet, please vote:

    junod tx gov vote 1 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-6 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v12.0.0-beta).

The Upgrade is scheduled for block `23400`, which should be about _1700 UTC on Weds 8th February_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/23400).

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git fetch --tags && git checkout v12.0.0-beta
make build && make install

# check the version - should be v12.0.0-beta
# junod version --long will be commit 3effc8146e9c4ade699402ae7f7f0ca560bf426e
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v12/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v12/bin

# find out what version you are about to run - should be v12.0.0-beta
$DAEMON_HOME/cosmovisor/upgrades/v12/bin/junod version
```
