// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";

contract ForceScript is Script {

    address payable forceInstanceAddress = payable(vm.envAddress("L07_FORCE_INSTANCE"));
    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");

    function run() public {
        vm.startBroadcast(privateKey);
        
        // WIP

        vm.stopBroadcast();
    }
}