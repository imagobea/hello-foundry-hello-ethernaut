# Token

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}
```

Level address 
`0x478f3476358Eb166Cb7adE4666d04fbdDB56C407`

## Goal v Vulnerability

Level is complete when the players' balance is bigger than the allocated upon contract deployment (see [TokenFactory](https://github.com/OpenZeppelin/ethernaut/blob/4d4c0a7fb969f69440153718d611b0c39b66a18c/contracts/contracts/levels/TokenFactory.sol#L21C28-L21C35))

v

Contract lacks protection against [overflow/underflow](https://solidity-by-example.org/hacks/overflow/).

Smart Contracts using Solidity < 0.8 overflow/underflow without any errors. In which cases code must be protected, e.g.

```
if (a + c > a) {
  a = a + c;
}
```

An easier alternative is to use OpenZeppelin SafeMath library that automatically checks for overflows in all the mathematical operators. The resulting code looks like this:

```
a = a.add(c);
```

If there is an overflow, the code will revert.

## Status

:green_circle: **Complete**!

NB: This example lacks a script because of the different Solidity versions!
