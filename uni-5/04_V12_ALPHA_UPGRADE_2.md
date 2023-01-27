# V12 Alpha-3 Upgrade

Welp, the last upgrade didn't succeed. Let's get ready to try again. The purpose of this upgrade is to rule out other potential issues and gather more infomation, and hopefully restore the testnet.

Unfortunately, `uni-5` is not in a great state, we signed one block post-upgrade and then halted. So we are going to revive from a snapshot just before the upgrade (block 1785500).

We suspect the problem is in the new `x/oracle / x/globalfee` module, so for this restart, we'll be turning OFF the price feeder. 

**These instructions build off of the [previous instructions](./03_V12_ALPHA_UPGRADE.md) and assumed you followed them.**

Stop node:

```sh
sudo systemctl stop junod
```

Stop oracle:

```sh
sudo systemctl disable oracle
sudo systemctl stop oracle
```

Install the latest v12 alpha binary w/ ICA fix and remove x/GlobalFee:

```sh
# get the new version & install
git fetch --tags
git checkout v12.0.0-alpha3
make build && make install

junod version --long
# name: juno
# server_name: junod
# version: v12.0.0-alpha3
# commit: 1401967c8662e74a49a7004d6e4d04fe6f4139e1
```

Download snapshot:

```sh
# Source
wget https://quicksync.cros-nest.com/transfer/uni-5-1785500.tar.lz4

# USA (Mirror)
wget https://reece.sh/private/fanmoskoasjkde/uni-5-1785500-directory.tar.lz4
```

Restore snapshot:

```sh
rm -rf $HOME/.juno/data
lz4 -dc < uni-5-1785500-directory.tar.lz4 | tar xvf - --directory $HOME/.juno
```

Set pruning to nothing & increase minimum fees back to before

```sh
nano $HOME/.juno/config/app.toml
# minimum-gas-prices = "0.0025ujunox" #(or higher)
# &
# pruning = "nothing"
```

Enable higher debugging from 'info' to 'trace'. Provided a successful launch, this can be set back to 'info' after the upgrade.

```sh
nano $HOME/.juno/config/config.toml
# log_level = "trace"
```

Ping the chat when ready.

We will start nodes `Monday at 1700 UTC (12 PM Eastern)`

```sh
sudo systemctl start junod
```
