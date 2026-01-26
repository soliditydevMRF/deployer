//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Airdroper {

    IERC20 public token;
    uint256 public amount; //100 000

    constructor(address _tokenAddress, uint256 _airdropAmount) {
        amount = _airdropAmount;
        token = IERC20(_tokenAddress);
    }

    function airdrop(address[] calldata receivers, uint256[] calldata amounts) external {
        require(receivers.length == amounts.length, "arrays length mismatch");
        require(token.allowance(msg.sender, address(this)) >= amount, "not enought approved tokens");

        for (uint256 i = 0; i < receivers.length; i++) {
            require(token.transferFrom(msg.sender, receivers[i], amounts[i]), "transfer failed");
        }

    }

}


/// pragma solidity ^0.8.29;
// import "./IUtilityContract.sol";

// contract BigBoss is IUtilityContract{

//     error AlareadyInitialized();

//     modifier notInitialized() {
//         require(!initialized, AlareadyInitialized());
//         _;
//     }

//     uint256 public number;
//     address public bigBoss;

//     bool private initialized;

//     function initialize(bytes memory _initData) notInitialized external returns(bool) {       
//         (uint256 _number, address _bigBoss) = abi.decode(_initData, (uint256, address));
//         number = _number;
//         bigBoss = _bigBoss;

//         initialized = true;
//         return true;
//     } 

//     function getInitData(uint256 _number, address _bigBoss) external pure returns(bytes memory ) {
//         return abi.encode(_number, _bigBoss);
//     }

//     function doSmth() external view returns(uint256, address) {
//         return (number, bigBoss);
//     }

// }
