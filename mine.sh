#!/bin/bash

# Mines fresh bitcoin every minute.

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

BTC_ADDRESS=`bitcoin-cli -regtest getnewaddress`

while true
do
    bitcoin-cli -regtest generatetoaddress 1 $BTC_ADDRESS
    sleep 60
done
