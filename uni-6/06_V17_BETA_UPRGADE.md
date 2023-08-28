# Uni v17 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v17.0.0-alpha.1).

The Upgrade is scheduled for block `3040483`, which should be about _1600 UTC on Thursday 31st Aug_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/3040483).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v17.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 2e4f4d1d93287639617bd5d5067a07746fd59caf
# cosmos_sdk_version: v0.47.4
# version: v17.0.0-alpha.1

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v17/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v17/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v17/bin/junod version
```
