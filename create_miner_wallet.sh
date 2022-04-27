#!/bin/bash

# Creates wallet $WALLET_NAME, if it is not yet present.

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

WALLET_NAME=regtest_miner_wallet

if [ "$(bitcoin-cli -regtest listwallets | grep -c ${WALLET_NAME})" -eq "0" ]; then
    bitcoin-cli -regtest -named createwallet wallet_name=${WALLET_NAME} load_on_startup=true
else
    echo Wallet ${WALLET_NAME} already present.
fi

