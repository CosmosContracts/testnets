# Astarte-3 Moneta Patch

Let's test patching from `v2.0.6` to `v2.1.0`.

The upgrade proposal is number 1, and you can query it via CLI.

```bash
junod q gov proposal 1 # prop info
junod q gov tally 1 # vote info
```

Please vote if you haven't yet.

The upgrade is scheduled for block `14500`, which should be about _17:00PM UTC on 21st December 2021_.

NOTE THAT THE FOLDER STRUCTURE HAS CHANGED TO `moneta-patch`

```bash
# get the new version
git checkout main && git pull
git checkout v2.1.0
make build && make install

# check the version - should be v2.1.0
# junod version --long will be commit e6b8c212b178cf575035065b78309aed547b1335
junod version

# if you are using cosmovisor you then need to copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/moneta-patch/bin
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta-patch/bin

# find out what version you are about to run - should be v2.1.0
$DAEMON_HOME/cosmovisor/upgrades/moneta-patch/bin/junod version
```
