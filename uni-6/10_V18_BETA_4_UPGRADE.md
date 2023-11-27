# Uni v1800alpha4 Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v18.0.0-alpha.4).

The Upgrade is scheduled for block `5640033`, which should be about _1700 UTC on Wednesday 29th Nov_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/5640033).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v18.0.0-alpha.4
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: a56c4421081db13d06e12d3a1ba466ee7d8d5896
# cosmos_sdk_version: v0.47.5
# version: v18.0.0-alpha.4

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v1800alpha4/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v1800alpha4/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v1800alpha4/bin/junod version
```
