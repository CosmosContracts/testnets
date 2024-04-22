# Uni v22 Beta Upgrade

This upgrade fixes bumps CosmosSDK and CometBFT to the latest compatible versions.

The Upgrade is scheduled for block `10121300`, which should be about _1500 UTC on Tuesday 23rd April_. [Here's a countdown](https://explorer.stavr.tech/Juno-Testnet/block/10121300).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
* Go Version 1.22+ is required

# get the new version
git fetch --tags && git checkout v22.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: b0faafbd6df4bb03940d99df13030af7f7bc315b
# cosmos_sdk_version: v0.47.11-0.20240417094812-f556fd956fb1
# version: v22.0.0

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v2200alpha1/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v2200alpha1/bin

# find out what version you are about to run - should be v22.0.0 or v22.0.0-alpha1 (they are the same)
$DAEMON_HOME/cosmovisor/upgrades/v2200alpha1/bin/junod version
```
