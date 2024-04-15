// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDelegation {
    function owner() external view returns(address);

    function pwn() external;
}

interface IDelegate {
    function owner() external view returns(address);
}
