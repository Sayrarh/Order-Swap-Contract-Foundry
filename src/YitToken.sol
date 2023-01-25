// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/solmate/src/tokens/ERC20.sol";

contract YitToken is ERC20("YitToken", "YIT", 18) {
    constructor(address user) {
        _mint(user, 100000e18);
    }
}
