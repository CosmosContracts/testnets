# Lupercalia Alpha

It's time to bring the-frey's blood pressure down and banish those night terrors. The time has come to integrate mainline wasmd into juno!

This also means you don't have to use the patched binary supplied by the core team - you can build this update yourself.

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v2.3.0-alpha.2).

The Upgrade is scheduled for block `364000`, which should be about _1700 UTC on 2nd February 2022_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v2.3.0-alpha.2
make build && make install

# check the version - should be v2.3.0-alpha.2
# junod version --long will be commit 7ec1d742f5e598c2455adb772c15cdfbdcf1bb9b
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin

# find out what version you are about to run - should be v2.3.0-alpha.2
$DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
