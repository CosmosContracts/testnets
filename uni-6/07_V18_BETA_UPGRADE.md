# Uni v18 (epona) Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v18.0.0-alpha.1).

The Upgrade is scheduled for block `4665656`, which should be about _1600 UTC on Friday 27th Oct_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/4665656).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v18.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 7c6745080a0fa56bd175bbc42ee07e841205a463
# cosmos_sdk_version: v0.47.5
# version: v18.0.0-alpha.1

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v18/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v18/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v18/bin/junod version
```
