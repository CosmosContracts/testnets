# Uni v21 Beta Upgrade

This upgrade fixes Mandrake Security Vulnerability.

For security reasons sourcecode is not published, and static-linked binary is provided.

The Upgrade is scheduled for block `8559900`, which should be about _1600 UTC on Monday 4th March_. [Here's a countdown](https://explorer.stavr.tech/Juno-Testnet/block/8559900).

As always, for unattended updates, [Cosmovisor is your friend](https://docs.cosmos.network/main/build/tooling/cosmovisor).

## Installation

```bash
# Download binary
curl -o junod https://security.junonetwork.io/v21.0.0/junod
chmod +x junod

# Verify shasum
shasum -a 256 junod
# f59baa3f5897a86ecf17c94087a49da2b1221dc1765e8580e9683b15a4635e3f  junod

# Check version
./junod version --long
# v21.0.0-alpha.1
# Deps redacted for security

# Backup old binary
cp ~/go/bin/junod ~/go/bin/junod-v20

# Move binary in proper folder
mv junod ~/go/bin/junod

# if you are using cosmovisor you then need to make a new dir and copy this new binary
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/v21/bin
cp $HOME/go/bin/junod $DAEMON_HOME/cosmovisor/upgrades/v21/bin

# find out what version you are about to run - should be the same as the tag
$DAEMON_HOME/cosmovisor/upgrades/v21/bin/junod version
```

## Code verification

For security reasons sourcecode for this patch is closed. If you are an expert validator with CosmosSDK developers in house, and maybe you are already aware of Mandrake security vulnerability ping @dimi to get access to the repository containing the patch.
