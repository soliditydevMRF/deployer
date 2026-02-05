//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;
import "./IUtilityContract.sol";
import "@openzeppelin/contracts/finance/VestingWallet.sol";




contract CroudFunding is VestingWallet {
    
    uint256 goal;
    address fundraiser;
    uint256 vestingDuration;
    bool private initialized;

    //             цель               собирает деньг   и
    constructor() {   _disableInitializers()}
      
      


    


    

    function initialize(bytes memory _initData)  external returns(bool) {       
        (uint256 _goal, address _fundraiser, uint256 _vestingDuration, address _owner)  = abi.decode(_initData, (uint256, address, uint256, address));        
           
        goal = _goal;
        vestingDuration = _vestingDuration;
        fundraiser = _fundraiser;
        Ownable.transferOwnership(_owner);

        initialized = true;

        return true;
    }   

    function getInitData(uint256 _goal, address _fundraiser, uint256 _vestingDuration, address _owner) external pure returns(bytes memory ) {
        return abi.encode(_goal, _fundraiser, _vestingDuration, _owner);
    }   





}