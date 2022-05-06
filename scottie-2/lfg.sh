#!/bin/bash

set -e

# e.g. scottie-2
CHAIN_ID="$1"

# set up add_genaccs.sh first
chmod a+x ./$CHAIN_ID/add_genaccs.sh
cp ./$CHAIN_ID/pre-genesis.json ~/.juno/config/genesis.json
cp ./$CHAIN_ID/gentx/* ~/.juno/config/gentx/
./$CHAIN_ID/add_genaccs.sh
junod collect-gentxs
junod validate-genesis
cp ~/.juno/config/genesis.json ./$CHAIN_ID/genesis.json