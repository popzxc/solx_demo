// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract CounterScript is Script {
    MyToken public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new MyToken();

        vm.stopBroadcast();
    }
}
