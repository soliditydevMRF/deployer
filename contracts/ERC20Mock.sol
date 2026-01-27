// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.5.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Mock is ERC20 {
    constructor(address recipient) ERC20("MYYTOKEN", "TOKEN") {
        _mint(recipient, 10000 * 10 ** decimals());
    }
}
//balance 10000000000000000000000
// деплоер последний аккаунт