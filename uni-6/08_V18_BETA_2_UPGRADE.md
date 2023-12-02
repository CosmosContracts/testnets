# Uni v1800alpha2 Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v18.0.0-alpha.2).

The Upgrade is scheduled for block `5036270`, which should be about _1700 UTC on Wednesday 8th Nov_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/5036270).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
# get the new version
git fetch --tags && git checkout v18.0.0-alpha.2
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 937bd9c91e742cb0a13a66ca760ed332aa527992
# cosmos_sdk_version: v0.47.5
# version: v18.0.0-alpha.2

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v1800alpha2/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v1800alpha2/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v1800alpha2/bin/junod version
```
