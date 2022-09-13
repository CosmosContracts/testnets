# Uni v10 Alpha Upgrade

It's been a while coming, but `uni-3` has one last job before we sunset it - testing v10 of Juno.

Among the crucial changes is an upgrade to `wasmvm v1.1.0` which will support [CosmWasm v1.1](https://medium.com/cosmwasm/cosmwasm-1-1-14233baf8162), and a bump of the Cosmos SDK to `v0.45.8`.

If you've not voted yet, please vote:

    junod tx gov vote 4 yes --gas-prices 0.1ujunox --gas-adjustment 1.3 --gas auto --chain-id uni-3 -y --from <key> -b block

More info on the changes in this proposed release can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v10.0.0-alpha).

The Upgrade is scheduled for block `1743818`, which should be about _1700 UTC on 15th Sept 2022_. [Here's a countdown](https://testnet.mintscan.io/juno-testnet/blocks/1743818).

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v10.0.0-alpha
make build && make install

# check the version - should be v10.0.0-alpha
# junod version --long will be commit 15ed7e88a4416f4be6e19076f42db4f620314a73
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v10/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v10/bin

# find out what version you are about to run - should be v10.0.0-alpha
$DAEMON_HOME/cosmovisor/upgrades/v10/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
