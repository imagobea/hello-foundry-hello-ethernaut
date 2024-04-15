# Telephone

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
```

Level address 
`0x2C2307bb8824a0AbBf2CC7D76d8e63374D2f8446`

## Goal v Vulnerability

Level is complete upon claiming ownership of the contract
[TelephoneFactory](https://github.com/OpenZeppelin/ethernaut/blob/4d4c0a7fb969f69440153718d611b0c39b66a18c/contracts/contracts/levels/TelephoneFactory.sol#L18)

```solidity
function validateInstance(address payable _instance, address _player) override public view returns (bool) {
  Telephone instance = Telephone(_instance);
  return instance.owner() == _player;
}
```

v

Confusing `tx.origin` with `msg.sender` can lead to [phishing-style attacks](https://solidity-by-example.org/hacks/phishing-with-tx-origin/).

## Status

:green_circle: **Complete**!

```bash
forge script script/ethernaut/04-telephone/Telephone.s.sol --rpc-url $RPC_ETH_TESTNET_SEPOLIA --broadcast -vvvv
```
