#!/bin/bash

# wait for the bitcoin node to bootstrap
sleep 5

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

/create_wallet.sh regtest_miner_wallet
/create_wallet.sh regtest_smartfee_wallet
/pre-mine.sh
/generate_transactions.sh regtest_miner_wallet regtest_smartfee_wallet &
/estimate_smartfee.sh &
exec /mine.sh
