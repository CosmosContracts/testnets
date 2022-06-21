# Multiverse ICA Host Upgrade

We're testing the upgrade handler that will enable ICA Host functionality.

If you've not voted yet, please vote on the software upgrade:

    junod tx gov vote 1 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-3 -y --from <key> -b block

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v7.0.0-alpha.2).

The Upgrade is scheduled for block `321500`, which should be about _1700 UTC on 14th June 2022_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v7.0.0-alpha.2
make build && make install

# check the version - should be v7.0.0-alpha.2
# junod version --long will be commit 3f1b85d41844ae7d382e3059a4c3d3ff2757c6a8
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/multiverse/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/multiverse/bin

# find out what version you are about to run - should be v7.0.0-alpha.2
$DAEMON_HOME/cosmovisor/upgrades/multiverse/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
