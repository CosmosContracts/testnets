# Uni v11 Alpha Upgrade

You will want to update IAVL config in `.juno/config/app.toml`. This should go in the base configuration section, e.g. under `index-events`:

```toml
# IavlCacheSize set the size of the iavl tree cache.
# Default cache size is 50mb.
iavl-cache-size = 781250

# IAVLDisableFastNode enables or disables the fast node feature of IAVL.
# Default is true.
iavl-disable-fastnode = false
```

Note - what you may have seen on other networks is the IAVL config setting `iavl-disable-fastnode` to true. We are going to see how long the migration takes on Uni to establish a ballpark time for mainnet.

If you've not voted yet, please vote:

    junod tx gov vote 2 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-5 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v11.0.0-alpha).

The Upgrade is scheduled for block `X`, which should be about _Y UTC on Z_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/20000).

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git fetch --tags
git checkout v11.0.0-alpha
make build && make install

# check the version - should be v11.0.0-alpha
# junod version --long will be commit b27fc7d9312267b293d3355dd4a06523d76e247f
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v11/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v11/bin

# find out what version you are about to run - should be v11.0.0-alpha
$DAEMON_HOME/cosmovisor/upgrades/v11/bin/junod version
```
