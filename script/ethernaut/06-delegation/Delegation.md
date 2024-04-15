# Delegation

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}
```

Level address 
`0x73379d8B82Fda494ee59555f333DF7D44483fD58`

## Goal v Vulnerability

Level is complete upon claiming ownership of the contract
[DelegationFactory](https://github.com/OpenZeppelin/ethernaut/blob/1a8a7313ecab87609ab35710ed286b821f4e0dd2/contracts/contracts/levels/DelegationFactory.sol#L25)

```solidity
function validateInstance(address payable _instance, address _player) override public view returns (bool) {
  Delegation parity = Delegation(_instance);
  return parity.owner() == _player;
}
```

v

Combination of `fallback` + `delegatecall`
The former is a special function that is executed when calling a function that does not exist.
The latter is a low level function. When contract A executes `delegatecall` to contract B, B's code is executed with contract A's storage, msg.sender and msg.value - from [Solidity By Example](https://solidity-by-example.org/delegatecall/).

## Status

:green_circle: **Complete**!

```bash
forge script script/ethernaut/06-delegation/Delegation.s.sol --rpc-url $RPC_ETH_TESTNET_SEPOLIA --broadcast -vvvv
```
