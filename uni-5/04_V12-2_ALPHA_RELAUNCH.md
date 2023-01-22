# Uni v12 Alpha Upgrade (Part 2)

This is a relaunch of the original v12 upgrade on Uni-5.

## Install the updated Junod binary

```bash
# get the new version which fixes ICA upgrade
git fetch --tags
git checkout v12.0.0-alpha2
make build && make install

# check the version - should be v12.0.0-alpha2
# junod version --long will be commit ?
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v12/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v12/bin

# find out what version you are about to run - should be v12.0.0-alpha2
$DAEMON_HOME/cosmovisor/upgrades/v12/bin/junod version
```

## Roll Back State

Roll back state to height `1785500` and hash `?` by performing

Option A)

```bash
sudo systemctl stop junod
junod rollback --home ~/.juno
```

Option B)

restore a snapshot created from height 1785500 - need to preserve and restore priv_validator_state when taking this path!

```bash
link: https://quicksync.cros-nest.com/transfer/uni-5-1785500.tar.lz4
md5-sum: ?
height: 1785500
size: ?
```

previously signed rounds of 1785500 must not be signed again - this is why we restore our validator state before starting up the node

if this fails:
last resort would be to use a state-export of block 1785500 to create a new genesis and re-launch uni-5 from this state.

### start chain again

Check if it works
if so, start feeders again.
else: remove GlobalFee, try again
