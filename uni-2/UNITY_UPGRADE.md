# Unity Beta

It's time to test the Unity candidate.

If you've not voted yet, please vote on the software upgrade:

```sh
junod tx gov vote 4 yes --fees 5000ujunox --gas auto --chain-id uni-2 -y --from <key>
```

This is a throwaway handler - for mainnet we will use the Unity handler.

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v4.0.0-beta).

The Upgrade is scheduled for block `1291500`, which should be about _1700 UTC on 1st May 2022_.


For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v4.0.0-beta
make build && make install

# check the version - should be v4.0.0-beta
# junod version --long will be commit c6f5860f73e3e4a31800ea044465814c096575e4
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/unity/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/unity/bin

# find out what version you are about to run - should be v4.0.0-beta
$DAEMON_HOME/cosmovisor/upgrades/unity/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
