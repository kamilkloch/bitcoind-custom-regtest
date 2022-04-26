#!/bin/bash
# wait a while for the bitcoin node to bootstrap
sleep 10

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

# Create miner's wallet
bitcoin-cli -regtest -named createwallet wallet_name=regtest_miner_wallet load_on_startup=true

BTC_ADDRESS=`bitcoin-cli -regtest getnewaddress`


bitcoin-cli -regtest generatetoaddress 200 $BTC_ADDRESS # generate some bitcon to miner's wallet
./estimate_smartfee.sh

while true
do
    bitcoin-cli -regtest generatetoaddress 1 $BTC_ADDRESS
    sleep 60
done
