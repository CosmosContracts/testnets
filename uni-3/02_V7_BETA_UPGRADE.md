# Uni v7 Beta Upgrade

We've cleaned up some dependencies of Juno, and we're paranoid, which means it's upgrade time before we can sign off v7.

If you've not voted yet, please vote on the software upgrade:

    junod tx gov vote 2 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-3 -y --from <key> -b block

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v7.0.0-beta).

The Upgrade is scheduled for block `XXX`, which should be about _1700 UTC on 23rd June 2022_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v7.0.0-beta
make build && make install

# check the version - should be v7.0.0-beta
# junod version --long will be commit 1291b66f3cd3529ad244391619f7b4166bb28373
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v7-beta/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v7-beta/bin

# find out what version you are about to run - should be v7.0.0-beta
$DAEMON_HOME/cosmovisor/upgrades/v7-beta/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
