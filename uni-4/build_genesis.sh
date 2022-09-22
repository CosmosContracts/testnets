#!/bin/sh

set -e

# You will need Juno set up on your machine to run this
# LFG
echo "> Compiling genesis using junod binary..."
which junod
junod version

echo "> Adding genesis accounts..."
cp ./pre-genesis.json $HOME/.juno/config/genesis.json
./add_genaccs.sh

echo "> Collecting gentxs..."
cp -r ./gentx $HOME/.juno/config/gentx
junod collect-gentxs &> /dev/null

echo "> Validating genesis..."
junod validate-genesis

# if valid you can then
# cp $HOME/.juno/config/genesis.json .