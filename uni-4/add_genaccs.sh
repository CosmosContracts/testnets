#!/bin/sh

# roguenet faucet
junod add-genesis-account juno1ntycamuz37p0mt8zrvamnvwrqax58xh5h06h8v 100000000000ujunox,100000000000uusdcx

# deus labs faucet
junod add-genesis-account juno16p9pe6ckrege6vpxdca0m5y93lz5j5zv0d9448 100000000000ujunox,100000000000uusdcx

# maxie
junod add-genesis-account juno1s7rj03089ayfqd3gqx9lr70hhf3kcvrvgy798z 100000000000ujunox,1000000000000uusdcx

# vals go here
find ./gentx -iname "*.json" -print0 |
    while IFS= read -r -d '' line; do
        VAL=$(jq -r '.body.messages[0].delegator_address' $line)
        junod add-genesis-account "$VAL" 10000000000ujunox
    done
