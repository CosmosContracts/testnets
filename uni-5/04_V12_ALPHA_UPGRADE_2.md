# V12 Alpha-2 Prep

Welp, the last upgrade didn't succeed. Let's get ready to try again.

Unfortunately, `uni-5` is not in a great state, we signed one block post-upgrade and then halted. So we are going to revive from a snapshot just before the upgrade (block 1785500).

We're 90% sure the problem is in the new `x/oracle / x/globalfee` module, so for this restart we'll be turning OFF the price feeder.

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

Install latest v12-alpha2 binary w/ ICA fix, Remove GlobalFee:

```sh
# get the new version
git fetch --tags
git checkout v12.0.0-alpha2
make build && make install

junod version --long
# name: juno
# server_name: junod
# version: v12.0.0-alpha2
# commit: 
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
lz4 -dc < uni-5-1785500-directory.tar.lz4 | tar xvf - --directory $HOME/.juno3
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

Start your node Monday at 1700UTC

```sh
sudo systemctl start junod
```

Ping the chat when you're done.
