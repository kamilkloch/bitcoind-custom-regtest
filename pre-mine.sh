#!/usr/bin/env bash

# Mines bitcoin until $WALLET_NAME contains at least $DESIRED_ACCOUNT_BALANCE

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

DESIRED_WALLET_BALANCE=100000
WALLET_NAME="regtest_miner_wallet"
BITCOIN_CLI_CMD="bitcoin-cli --rpcwallet=${WALLET_NAME}"

LC_NUMERIC="en_US.UTF-8"

while true
do
  balance="$(${BITCOIN_CLI_CMD} getbalance)"
  rounded_balance=$(printf "%.0f" "${balance}")
  if (( rounded_balance > DESIRED_WALLET_BALANCE)); then
    exit 0;
  fi
  bitcoin-cli generatetoaddress 100 "$(${BITCOIN_CLI_CMD} getnewaddress)"
done
