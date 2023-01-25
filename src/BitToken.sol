// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/solmate/src/tokens/ERC20.sol";

contract BitToken is ERC20("BitToken", "BIT", 18) {
    constructor(address user) {
        _mint(user, 100000e18);
    }

}
