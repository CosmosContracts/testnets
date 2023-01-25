# V12 Alpha-2 Prep

Welp, the last upgrade didn't succeed. Let's get ready to try again.

Unfortunately, `uni-5` is not in a great state, we signed one block post-upgrade and then halted. So we are going to revive from a snapshot just before the upgrade (block 1785500).

We're 90% sure the problem is in the new `x/oracle` module, so for this restart we'll be turning OFF the price feeder.

**These instructions build off of the [previous instructions](./03_V12_ALPHA_UPGRADE.md), and assumed you followed them.**

Stop node:

```sh
sudo systemctl stop junod
```

Reset:

```sh
junod tendermint unsafe-reset-all
```

Switch back to the previous version (note you should already have the `v12` ready to go as described in the previous instructions):

```sh
# get the old version
git fetch --tags
git checkout v11.0.0-alpha
make build && make install
```

Download snapshot:

```sh
wget https://reece.sh/private/fanmoskoasjkde/uni-5-1785500-directory.tar.lz4
```

Restore snapshot:

```sh
lz4 -dc < uni-5-1785500-directory.tar.lz4 | tar xvf - --directory ~/.juno
```

Stop oracle:

```sh
sudo systemctl disable oracle
sudo systemctl stop oracle
```

Restart your node

```sh
sudo systemctl start junod
```

Ping the chat when you're done.
