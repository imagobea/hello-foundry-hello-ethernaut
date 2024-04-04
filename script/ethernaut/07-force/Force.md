# Force

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}
```

Level address
`0xb6c2Ec883DaAac76D8922519E63f875c2ec65575`

## Goal v Vulnerability

Level is complete upon funding the contract
[ForceFactory](https://github.com/OpenZeppelin/ethernaut/blob/c8860dc9a24878d636bacb1648b40ccb4336aa77/contracts/contracts/levels/ForceFactory.sol#L15)

```solidity
function validateInstance(address payable _instance, address _player) override public view returns (bool) {
  _player;
  Force instance = Force(_instance);
  return address(instance).balance > 0;
}
```

v

??

## Status

WIP
