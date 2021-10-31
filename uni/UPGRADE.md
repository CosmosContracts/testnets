# Moneta Alpha

The time has come to start testing Moneta on uni. The upgrade proposal is [here](https://uni.junoscan.com/proposals/1).

The Upgrade is scheduled for block `250,130`, which should be about _3PM UTC on Monday 1st November_.

A good bet is to check in beforehand to get a feel for whether the block will arrive early or late. Since this was generated a few days in advance based on an estimated block height, it could easily be +/- over an hour.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git pull
git checkout v2.0.0-alpha.2
make build && make install

# check the version - should be v2.0.0-alpha.2
# junod version --long will be commit 7bebb5dc339f21e892f9f6e7b1d63b1035ccc402
junod version

# if you are using cosmovisor you then need to copy this new binary
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta-alpha/bin

# find out what version you are about to run - should be v2.0.0-alpha.2
.juno/cosmovisor/upgrades/moneta-alpha/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
