# Uni v10 Alpha 1 Upgrade

Due to the issues we had with the previous v10, we've backed out of bringing in the wasmd changes we wanted, and instead are focussed on shipping mint.

If you've not voted yet, please vote:

    junod tx gov vote 1 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-34 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v10.0.0-alpha.1).

The Upgrade is scheduled for block `X`, which should be about _Y UTC on Zth Sept 2022_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/X).

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v10.0.0-alpha.1
make build && make install

# check the version - should be v10.0.0-alpha.1
# junod version --long will be commit foo
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v10/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v10/bin

# find out what version you are about to run - should be v10.0.0-alpha.1
$DAEMON_HOME/cosmovisor/upgrades/v10/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
