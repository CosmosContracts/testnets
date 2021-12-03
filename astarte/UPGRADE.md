# Moneta

It's Moneta time, baby. The upgrade proposal is number 1, and you can query it via CLI.

```bash
junod q gov proposal 1 # prop info
junod q gov tally 1 # vote info
```

The Upgrade is scheduled for block `28900`, which should be about _5PM UTC on 5th December 2021_.

Look, we've messed up block times before, we're all tired, so check in beforehand to see what the ETA is if you're doing this by hand...

But let's face it, you're using, [cosmovisor](https://docs.junochain.com/validators/setting-up-cosmovisor), so this upgrade will happen while you're down at the pub.

```bash
# get the new version
git pull
git checkout v2.0.0
make build && make install

# check the version - should be v2.0.0
# junod version --long will be commit fa88eb0a4760795dcd03f30754e43161d7ce2681
junod version

# if you are using cosmovisor you then need to copy this new binary
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta/bin

# find out what version you are about to run - should be v2.0.0
$DAEMON_HOME/cosmovisor/upgrades/moneta/bin/junod version
```

YOLO LFG WAGMI 🚀🌙
