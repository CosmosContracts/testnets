# Uni v16 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v16.0.0-alpha.1).

The Upgrade is scheduled for block `2401803`, which should be about _1600 UTC on Tuesday 18th July_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/2401803).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v16.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 3c2e8c839f9c2b1d673d4afeb886195e1b335479
# cosmos_sdk_version: v0.47.3
# version: v16.0.0-alpha.1

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v16/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v16/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v16/bin/junod version
```
