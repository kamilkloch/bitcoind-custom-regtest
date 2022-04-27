# bitcoind-custom-regtest

Patched version of Bitcoin regtest:
  - halving interval increased to mainnet and testnet values
  - halving occurs every 210 000 blocks, instead of default 150
  - `regtest_miner_wallet` created
  - 200k BTC mined and deposited into the `regtest_miner_wallet` 
  - running mining script which generates a new block every minute
  - estimatesmartfee (https://bitcoincore.org/en/doc/22.0.0/rpc/util/estimatesmartfee/) is initialized

GitHub Repository is available at [kamilkloch/bitcoind-custom-regtest](https://github.com/kamilkloch/bitcoind-custom-regtest).

## Building

```bash
docker build -t bitcoind-custom-regtest:latest .
```

## Usage

```bash
docker run -p 19001:19001 -p 19000:19000 -p 28332:28332 bitcoind-custom-regtest:latest
```

By default RPC is available on port 19001 with username `test` and password `test`.
