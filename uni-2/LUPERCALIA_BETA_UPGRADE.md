# Lupercalia Beta

Okay, so that last one didn't go so well 🤣 RIP `uni-1`, you were the best.

Time to try again.

*Slaps roof of `uni-2`.* This f@@@en testnet can fit so many chain halts in it.

Yes that was a meme in text form.

If you've not voted yet, please vote on the software upgrade:

```sh
junod tx gov vote 1 yes --fees 5000ujunox --gas auto --chain-id uni-2 --from <key>
```

Just like for the alpha that sadly didn't work, you don't have to use the patched binary supplied by the core team - you can build this update yourself.

More info on the updates in this change can be found [on the release page](https://github.com/CosmosContracts/juno/releases/tag/v2.3.0-beta).

The Upgrade is scheduled for block `104800`, which should be about _1700 UTC on 11th February 2022_.

For unattended updates, [cosmovisor is your friend](https://docs.junochain.com/validators/setting-up-cosmovisor).

```bash
# get the new version
git checkout main && git pull
git checkout v2.3.0-beta
make build && make install

# check the version - should be v2.3.0-beta
# junod version --long will be commit d323777476c68c31bd906492c223fc42acf70e30
junod version

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin

# find out what version you are about to run - should be v2.3.0-beta
$DAEMON_HOME/cosmovisor/upgrades/lupercalia/bin/junod version
```

The chain will automatically halt at the target height, at which point you can manually replace the binary.

However, we _strongly recommend_ using an automation tool such as cosmovisor, using [this guide](https://docs.junochain.com/validators/setting-up-cosmovisor).
