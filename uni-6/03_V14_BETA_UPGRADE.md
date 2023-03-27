# Uni v14 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v14.0.0-alpha.1).

The Upgrade is scheduled for block `770462`, which should be about _1600 UTC on Thursday 30th Mar_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/770462).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git fetch --tags && git checkout v14.0.0-alpha.1
make build && make install

junod version --long
# check the version - should be v14.0.0-alpha.1
# commit: e10e3241c9ec146670f1a08540104f017bed210c

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v13/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v13/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v13/bin/junod version
```
