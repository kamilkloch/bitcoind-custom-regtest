#!/bin/bash

# wait for the bitcoin node to bootstrap
sleep 10

# Stops the execution of a script if a command or pipeline has an error -
# the opposite of the default shell behaviour, which is to ignore errors in scripts.
set -euo pipefail

/create_miner_wallet.sh
/pre-mine.sh
/estimate_smartfee.sh
exec /mine.sh
