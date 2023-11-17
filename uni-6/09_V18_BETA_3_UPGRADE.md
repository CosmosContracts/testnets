# Uni v1800alpha3 Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v18.0.0-alpha.3).

The Upgrade is scheduled for block `5382845`, which should be about _1700 UTC on Monday 20th Nov_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/5382845).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v18.0.0-alpha.3
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 879e4c2ae406f433897a70d84d22cd88f2fe88a2
# cosmos_sdk_version: v0.47.5
# version: v18.0.0-alpha.3

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v1800alpha3/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v1800alpha3/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v1800alpha3/bin/junod version
```
