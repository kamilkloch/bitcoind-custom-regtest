#!/bin/bash

# Mines fresh bitcoin every minute.

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

WALLET_NAME="regtest_miner_wallet"
BITCOIN_CLI_CMD="bitcoin-cli -regtest --rpcwallet=${WALLET_NAME}"

BTC_ADDRESS=$(${BITCOIN_CLI_CMD} getnewaddress)

while true
do
    ${BITCOIN_CLI_CMD} generatetoaddress 1 $BTC_ADDRESS
    sleep 60
done
