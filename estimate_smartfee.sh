#!/usr/bin/env bash

# Generates transactions until `bitcoin-cli estimatesmartfee` returns a valid estimate.
# Assumes bitcoin for transactions is available on $SOURCE_WALLET
# Runs periodically every 30s.

# https://bitcoin.stackexchange.com/a/107319/133897

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -eo pipefail

SOURCE_WALLET="regtest_miner_wallet"
DEST_WALLET="regtest_smartfee_wallet"
BITCOIN_CLI_CMD="bitcoin-cli --rpcwallet=${SOURCE_WALLET}"

estimatesmartfee() {
  local cont=true

  smartfee=$(bitcoin-cli estimatesmartfee 6)
  if [[ "$smartfee" == *"\"feerate\":"* ]]; then
    return
  fi

  while $cont; do
    counterb=0
    range=$(($RANDOM % 11 + 20))
    while [ $counterb -lt $range ]; do
      power=$(($RANDOM % 29))
      randfee=$(echo "scale=8; 0.00001 * (1.1892 ^ $power)" | bc)
      newaddress=$(bitcoin-cli --rpcwallet=${DEST_WALLET} getnewaddress)
      rawtx=$(${BITCOIN_CLI_CMD} createrawtransaction "[]" "[{\"$newaddress\":0.005}]")
      fundedtx=$(${BITCOIN_CLI_CMD} fundrawtransaction "$rawtx" "{\"feeRate\": \"0$randfee\"}" | jq -r ".hex")
      signedtx=$(${BITCOIN_CLI_CMD} signrawtransactionwithwallet "$fundedtx" | jq -r ".hex")
      senttx=$(${BITCOIN_CLI_CMD} sendrawtransaction "$signedtx")
      ((++counterb))
      echo "Created $counterb transactions this block"
    done
    ${BITCOIN_CLI_CMD} generatetoaddress 1 "mp76nrashrCCYLy3a8cAc5HufEas11yHbh"
    smartfee=$(bitcoin-cli estimatesmartfee 6)
    if [[ "$smartfee" == *"\"feerate\":"* ]]; then
      cont=false
    fi
  done

  bitcoin-cli generatetoaddress 6 "$(${BITCOIN_CLI_CMD} getnewaddress)"
}

while true; do
  estimatesmartfee
  sleep 60
done
