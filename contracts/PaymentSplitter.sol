//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/finance/VestingWallet.sol";

contract OwrContract is VestingWallet {
    constructor(address _beneficiary, uint64 _duration) VestingWallet(_beneficiary, uint64 (block.timestamp), _duration) payable {}

    

  


}



// ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]  ["70","30"]