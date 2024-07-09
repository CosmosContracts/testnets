# Uni v23 Beta Upgrade

This upgrade includes:

- Version bumps
    - cometbft from v0.37.6 to v0.37.8
    - cosmos-sdk from v0.47.11 to v0.47.12
    - async-icq from v7.0.0 to v7.1.1
    - ibc-go from v7.4.0 to v7.6.0
    - skip/pob from v1.0.4 to v1.0.5
- Fix of a wrongly created module account for skip/pob module, related to the recent tokenfactory break
- Migration to community pool of Dimi’s, Jake’s and Lobo’s leftover vesting amount (around 553,035 $JUNO total)
- Updates to tokenfactory module for better error handling

The Upgrade is scheduled for block `12595500`, which should be about _1500 UTC on Wednesday 10th July_. [Here's a countdown](https://explorer.stavr.tech/Juno-Testnet/block/12595500).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

Upgrade plan name is "v23"

## Installation

```bash
* Go Version 1.22+ is required

# get the new version
git fetch --tags && git checkout v23.0.0-alpha.1
make build && make install

junod version --long | grep "cosmos_sdk_version\|commit\|version:"
# commit: bf140aa60045ba92b83d0cb7f3bc47a2661a4e7e
# cosmos_sdk_version: v0.47.12
# version: v23.0.0-alpha.1

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v23/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v23/bin

# find out what version you are about to run - should be v23.0.0 or v23.0.0-alpha.1 (they are the same)
$DAEMON_HOME/cosmovisor/upgrades/v23/bin/junod version
```
