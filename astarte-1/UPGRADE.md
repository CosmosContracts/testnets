# Astarte-1 Moneta

It's Moneta time, hopefully for the last time 😉🤣. The upgrade proposal is number 1, and you can query it via CLI.

```bash
junod q gov proposal 1 # prop info
junod q gov tally 1 # vote info
```

The Upgrade is scheduled for block `19000`, which should be about _11PM UTC on 7th December 2021_.

You can either YOLO and assume cosmovisor will have your back (it probably will), or check in on Discord around the upgrade time.

```bash
# get the new version
git checkout main && git pull
git checkout v2.0.3
make build && make install

# check the version - should be v2.0.3
# junod version --long will be commit 4e3a1463be4ecb52450a15b2dd2690f37a109fd8
junod version

# if you are using cosmovisor you then need to copy this new binary
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta/bin

# find out what version you are about to run - should be v2.0.3
$DAEMON_HOME/cosmovisor/upgrades/moneta/bin/junod version
```

One last tango y'all 💃
