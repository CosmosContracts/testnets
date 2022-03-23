# Lupercalia Beta 2

It's time to test the final Lupercalia candidate. This one has some sec fixes etc that we want to mainnet.

If you've not voted yet, please vote on the software upgrade:

```sh
junod tx gov vote 2 yes --fees 5000ujunox --gas auto --chain-id uni-2 --from <key>
```

This is a throwaway handler - for mainnet we will use the Lupercalia handler.

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v2.3.0-beta.2).

The Upgrade is scheduled for block `723300`, which should be about _1700 UTC on 24th March 2022_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v2.3.0-beta.2
make build && make install

# check the version - should be v2.3.0-beta.2
# junod version --long will be commit 9a1c32f508e6314fb73e57db35313cb329639424
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/lupercalia-beta/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/lupercalia-beta/bin

# find out what version you are about to run - should be v2.3.0-beta.2
$DAEMON_HOME/cosmovisor/upgrades/lupercalia-beta/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
