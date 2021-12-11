# Astarte-2 Moneta

OKAY when we said the last upgrade and testnet was the last time, we were obviously joking. Clearly it's not a 🌶🌶🌶🔥 enough upgrade unless you're testing until the last possible second.

The upgrade proposal is number 1, and you can query it via CLI.

```bash
junod q gov proposal 1 # prop info
junod q gov tally 1 # vote info
```

The Upgrade is scheduled for block `30000`, which should be about _17:30PM UTC on 12th December 2021_.

You can either YOLO and assume cosmovisor will have your back or check Discord tomorrow. We have a set of about 11 validators so PLEASE AUTOMATE THE UPGRADE or I will be sad 😢

```bash
# get the new version
git checkout main && git pull
git checkout v2.0.4
make build && make install

# check the version - should be v2.0.4
# junod version --long will be commit X
junod version

# if you are using cosmovisor you then need to copy this new binary
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/moneta/bin

# find out what version you are about to run - should be v2.0.4
$DAEMON_HOME/cosmovisor/upgrades/moneta/bin/junod version
```

WAGMI
