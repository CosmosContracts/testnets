# Uni v14 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v14.0.0-alpha.1).

The Upgrade is scheduled for block `770462`, which should be about _1600 UTC on Thursday 30th Mar_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/770462).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

## Setup

This update requires a modification to all validator's app.toml. Please make sure to update your app.toml to include the following:

```toml
# Update app.toml key:

minimum-gas-prices = "0ujunox"

# NOTE: mainnet will be ujuno & the atom ibc denom
# Fees are now done through governance for the minimums. 
# Provided a network spam attack, you may raise your fees above the default 0.0025ujunox limit
```

## Installation

```bash
# get the new version
git fetch --tags && git checkout v14.0.0-alpha.1
make build && make install

junod version --long
# check the version - should be v14.0.0-alpha.1
# commit: e10e3241c9ec146670f1a08540104f017bed210c

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v14/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v14/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v14/bin/junod version
```
