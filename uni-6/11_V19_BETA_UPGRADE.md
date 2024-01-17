# Uni v19 Beta Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v19.0.0-alpha.1).

The Upgrade is scheduled for block `7194366`, which should be about _1700 UTC on Friday 19th Jan_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/7194366).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v19.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 55ec22a51f95f773f91ab06e2a64b305728ef35b
# cosmos_sdk_version: v0.47.6
# version: v19.0.0-alpha.1

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v19/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v19/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v19/bin/junod version
```
