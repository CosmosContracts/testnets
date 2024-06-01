# Uni v19 Beta 3 Upgrade

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v19.0.0-alpha.3).

The Upgrade is scheduled for block `7492708`, which should be about _1600 UTC on Monday 29th Jan_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/7492708).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
* Go Version 1.21+ is required

# get the new version
git fetch --tags && git checkout v19.0.0-alpha.3
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: 46bc071f91225d2dcf06897d7b71f668f5508087
# cosmos_sdk_version: v0.47.6
# version: v19.0.0-alpha.3

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v1900alpha3/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v1900alpha3/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v1900alpha3/bin/junod version
```
