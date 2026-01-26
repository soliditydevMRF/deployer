//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IUtilityContract.sol";

contract ERC20Airdroper is IUtilityContract {

    error AlareadyInitialized();
    error NotEnoughtApprovedTokens();
    error ArraysLengthMismatch();
    error TransferFailed();

    modifier notInitialized() {
        require(!initialized, AlareadyInitialized());
        _;
    }

  
    IERC20 public token;          
    uint256 public airdropAmount;
    bool private initialized;
    

    function initialize(bytes memory _initData) notInitialized external returns(bool) {       
        (address _tokenAddress, uint256 _airdropAmount)  = abi.decode(_initData, (address, uint256));
        
        token = IERC20(_tokenAddress);       
        airdropAmount = _airdropAmount;
        initialized = true;

        return true;
    }     

    function airdrop(address[] calldata _receivers, uint256[] calldata _amounts) external {
        require(_receivers.length == _amounts.length, ArraysLengthMismatch());
        require(token.allowance(msg.sender, address(this)) >= airdropAmount, NotEnoughtApprovedTokens());

        for (uint256 i = 0; i < _receivers.length; i++) {
            require(token.transferFrom(msg.sender, _receivers[i], _amounts[i]), TransferFailed());
        }
    }

    function getInitData(address tokenAddress, uint256 _airdropAmount) external pure returns(bytes memory ) {
        return abi.encode(tokenAddress, _airdropAmount);
    }    

}
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]

