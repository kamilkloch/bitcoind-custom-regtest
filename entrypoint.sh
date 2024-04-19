#!/bin/bash

/initialize_and_mine.sh &
exec bitcoind -datadir="${BITCOIN_DATA}" -conf="/.bitcoin/bitcoin.conf"
