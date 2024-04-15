# Coin Flip

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
```

Level address 
`0xA62fE5344FE62AdC1F356447B669E9E6D10abaaF`

## Goal v Vulnerability

Level is complete upon 10 `consecutiveWins`
[CoinFlipFactory](https://github.com/OpenZeppelin/ethernaut/blob/4d4c0a7fb969f69440153718d611b0c39b66a18c/contracts/contracts/levels/CoinFlipFactory.sol#L17)

```solidity
function validateInstance(address payable _instance, address) override public view returns (bool) {
  CoinFlip instance = CoinFlip(_instance);
  return instance.consecutiveWins() >= 10;
}
```

v

Coin side can be guessed (poor source of randomness).

## Status

:red_circle: **Incomplete**. Sepolia is too busy, so by the time the transaction is broadcasted and mined, it goes into a different block (different block number than the one used to make the "flip guess").

```bash
forge script script/ethernaut/03-coinflip/CoinFlip.s.sol --rpc-url $RPC_ETH_TESTNET_SEPOLIA --broadcast -vvvv
```
