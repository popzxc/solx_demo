// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public token;

    function setUp() public {
        token = new MyToken();
    }

    function test_Name() public view {
        assertEq(token.name(), "MyToken");
    }

    function test_Symbol() public view {
        assertEq(token.symbol(), "MT");
    }

    function test_Transfer() public {
        uint fromBefore = token.balanceOf(address(this));
        address to = address(0x1);
        token.transfer(to, 100);
        assertEq(token.balanceOf(to), 100);
        assertEq(token.balanceOf(address(this)), fromBefore - 100);
    }

    function test_approve() public {
        address spender = address(0x1);
        token.approve(spender, 100);
        assertEq(token.allowance(address(this), spender), 100);
    }

    function test_transferFrom() public {
        address spender = address(0x1);
        token.approve(spender, 100);

        vm.prank(spender);
        token.transferFrom(address(this), spender, 100);
        assertEq(token.balanceOf(spender), 100);
    }
}
