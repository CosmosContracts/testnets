# Uni v15 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v15.0.0-alpha.1).

The Upgrade is scheduled for block `1619811`, which should be about _1600 UTC on Friday 26th May_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/1619811).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v15.0.0-alpha.1
make build && make install

rm -rf $HOME/.juno/data/wasm/cache/

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# version: v15.0.0-alpha.1
# commit: b7901a7494fe5112dfa5b0b9d5f95d2c2e60c27f
# cosmos_sdk_version: v0.45.16

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v15/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v15/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v15/bin/junod version
```
