# Lupercalia Alpha

It's time to bring the-frey's blood pressure down and banish those night terrors. The time has come to integrate mainline wasmd into juno!

This also means you don't have to use the patched binary supplied by the core team - you can build this update yourself.

The Upgrade is scheduled for block `X`, which should be about _XPM UTC on X_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v2.3.0-alpha.1
make build && make install

# check the version - should be v2.3.0-alpha.1
# junod version --long will be commit 247625365273c071712921d64cdabb30240a1625
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin
cp /home/<your-user>/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/Lupercalia/bin

# find out what version you are about to run - should be v2.3.0-alpha.1
.juno/cosmovisor/upgrades/lupercalia/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
