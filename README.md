# bitcoind-custom-regtest

Patched version of Bitcoin regtest with halving interval increased to mainnet and testnet values. 
Halving occurs every 210000 blocks, instead of default 150.

GitHub Repository is available at [kamilkloch/bitcoind-custom-regtest](https://github.com/kamilkloch/bitcoind-custom-regtest).

## Building

```
docker build -t bitcoind-custom-regtest:latest .
```

## Usage

```
docker run -p 19001:19001 -p 19000:19000 -p 28332:28332 bitcoind-custom-regtest:latest
```

By default RPC is available on port 19001 with username `test` and password `test`.
Image includes a mining script which generates a new block every minute. Bitcoin node has wallet feature enabled.

Coins are readily available on start (node is advanced by 200 blocks on start),
estimatesmartfee (https://bitcoincore.org/en/doc/22.0.0/rpc/util/estimatesmartfee/) is initialized.
