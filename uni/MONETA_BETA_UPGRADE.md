# Moneta Beta

It's time for the final round of upgrade testing. The upgrade proposal is [here](https://uni.junoscan.com/proposals/4).

The Upgrade is scheduled for block `589,705`, which should be about _4PM UTC on Friday 26th Nov_.

Please check in on the day to see whether the target block will be early or late. +/- more than an hour is not uncommon.

As always, for unattended updates, [use cosmovisor](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main # in case you are in detatched HEAD
git pull
git checkout v2.0.0-beta.1
make build && make install

# check the version - should be v2.0.0-beta.1
# junod version --long will be commit 99cc3d5b2576c3b5a733d6cf6fe1f9c0fb99b0e6
junod version

# if you are using cosmovisor you then need to copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/moneta-beta/bin
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta-beta/bin

# find out what version you are about to run - should be v2.0.0-beta.1
$HOME/.juno/cosmovisor/upgrades/moneta-beta/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).

Let's gooo! 🚀
