# Uni v13 Beta Upgrade

Okay folks, as you know, we've split the original v12 into 3 parts.

Part one is now on mainnet, this is part 2. Due to fun with git tags, we're not using the alpha tag and instead going straight to `v13.0.0-beta`.

If you've not voted yet, please vote:

    junod tx gov vote 6 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-6 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v13.0.0-beta).

The Upgrade is scheduled for block `262300`, which should be about _1700 UTC on Friday 24th Feb_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/262300).

As always, for unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git fetch --tags && git checkout v13.0.0-beta
make build && make install

# check the version - should be v13.0.0-beta
# junod version --long will be commit a3f41b74b39ae9326962bf183d699081d2840f76
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v13/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v13/bin

# find out what version you are about to run - should be v13.0.0-beta
$DAEMON_HOME/cosmovisor/upgrades/v13/bin/junod version
```
