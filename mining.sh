#!/bin/bash
# wait a while for the bitcoin node to bootstrap
sleep 10

# Create miner's wallet
bitcoin-cli -regtest -named createwallet wallet_name=regtest_miner_wallet load_on_startup=true

BTC_ADDRESS=`bitcoin-cli -regtest getnewaddress`
while true
do
    bitcoin-cli -regtest generatetoaddress 1 $BTC_ADDRESS || true
    sleep 60
done
