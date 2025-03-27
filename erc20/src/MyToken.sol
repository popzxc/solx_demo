// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@solady-tokens/ERC20.sol";

contract MyToken is ERC20 {
    constructor() {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }

    function name() public pure override returns (string memory) {
        return "MyToken";
    }

    function symbol() public pure override returns (string memory) {
        return "MT";
    }
}
