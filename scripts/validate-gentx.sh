#!/bin/sh
JUNOD_HOME="/tmp/junod$(date +%s)"
RANDOM_KEY="randomjunodvalidatorkey"
CHAIN_ID=hera
DENOM=ujuno
MAXBOND=50000000000 # 50000JUNO

GENTX_FILE=$(find ./$CHAIN_ID/gentxs -iname "*.json")
LEN_GENTX=$(echo ${#GENTX_FILE})

# Gentx Start date
start="2021-08-30 10:00:00Z"
# Compute the seconds since epoch for start date
stTime=$(date --date="$start" +%s)

# Gentx End date
end="2021-09-01 10:00:00Z"
# Compute the seconds since epoch for end date
endTime=$(date --date="$end" +%s)

# Current date
current=$(date +%Y-%m-%d\ %H:%M:%S)
# Compute the seconds since epoch for current date
curTime=$(date --date="$current" +%s)

if [[ $curTime < $stTime ]]; then
    echo "start=$stTime:curent=$curTime:endTime=$endTime"
    echo "Gentx submission is not open yet. Please close the PR and raise a new PR after 30-August-2021 10:00:00 UTC"
    exit 0
else
    if [[ $curTime > $endTime ]]; then
        echo "start=$stTime:curent=$curTime:endTime=$endTime"
        echo "Gentx submission is closed"
        exit 0
    else
        echo "Gentx is now open"
        echo "start=$stTime:curent=$curTime:endTime=$endTime"
    fi
fi

if [ $LEN_GENTX -eq 0 ]; then
    echo "No new gentx file found."
else
    set -e

    echo "GentxFile::::"
    echo $GENTX_FILE

    echo "...........Init Juno.............."

    git clone https://github.com/CosmosContracts/Juno
    cd Juno
    git checkout hera
    make build
    chmod +x ./build/junod

    ./build/junod keys add $RANDOM_KEY --keyring-backend test --home $JUNOD_HOME

    ./build/junod init --chain-id $CHAIN_ID validator --home $JUNOD_HOME

    echo "..........Fetching genesis......."
    rm -rf $JUNOD_HOME/config/genesis.json
    curl -s https://raw.githubusercontent.com/CosmosContracts/testnets/$CHAIN_ID/genesis-prelaunch.json >$JUNOD_HOME/config/genesis.json

    # this genesis time is different from original genesis time, just for validating gentx.
    sed -i '/genesis_time/c\   \"genesis_time\" : \"2021-09-02T16:00:00Z\",' $JUNOD_HOME/config/genesis.json

    GENACC=$(cat ../$GENTX_FILE | sed -n 's|.*"delegator_address":"\([^"]*\)".*|\1|p')
    denomquery=$(jq -r '.body.messages[0].value.denom' ../$GENTX_FILE)
    amountquery=$(jq -r '.body.messages[0].value.amount' ../$GENTX_FILE)

    echo $GENACC
    echo $amountquery
    echo $denomquery

    # only allow $DENOM tokens to be bonded
    if [ $denomquery != $DENOM ]; then
        echo "invalid denomination"
        exit 1
    fi

    # limit the amount that can be bonded

    if [ $amountquery -gt $MAXBOND ]; then
        echo "bonded too much: $amountquery > $MAXBOND"
        exit 1
    fi

    ./build/junod add-genesis-account $RANDOM_KEY 100000000000000$DENOM --home $JUNOD_HOME \
        --keyring-backend test

    ./build/junod gentx $RANDOM_KEY 90000000000000$DENOM --home $JUNOD_HOME \
        --keyring-backend test --chain-id $CHAIN_ID

    cp ../$GENTX_FILE $JUNOD_HOME/config/gentx/

    echo "..........Collecting gentxs......."
    ./build/junod collect-gentxs --home $JUNOD_HOME
    sed -i '/persistent_peers =/c\persistent_peers = ""' $JUNOD_HOME/config/config.toml

    ./build/junod validate-genesis --home $JUNOD_HOME

    echo "..........Starting node......."
    ./build/junod start --home $JUNOD_HOME &

    sleep 5s

    echo "...checking network status.."

    ./build/junod status --node http://localhost:26657

    echo "...Cleaning the stuff..."
    killall junod >/dev/null 2>&1
    rm -rf $JUNOD_HOME >/dev/null 2>&1
fi
