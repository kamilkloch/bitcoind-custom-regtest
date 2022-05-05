#!/usr/bin/env bash

# Generates random transactions from source wallet to dest wallet
# Runs periodically every ~10s.

if [ -z "$1" ]; then
    echo "Usage: $0 <source_wallet> <dest_wallet>"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Usage: $0 <source_wallet> <dest_wallet>"
    exit 1
fi

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -eo pipefail

SOURCE_WALLET="$1"
DEST_WALLET="$2"

send() {
  dest_address="$(bitcoin-cli -regtest --rpcwallet=${DEST_WALLET} getnewaddress)"
  fee=$((1 + $RANDOM % 20))
  bitcoin-cli -regtest --rpcwallet=${SOURCE_WALLET} -named sendtoaddress address="${dest_address}" amount=0.0005 fee_rate=${fee}
}

while true; do
  send
  sleep $((1 + $RANDOM % 10))
done
