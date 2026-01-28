//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../IUtilityContract.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vesting is IUtilityContract, Ownable {

    constructor() Ownable(msg.sender){}

    bool private initialized;
    IERC20 public token;  
    uint256 public amount;
    address public beneficiary;      //получатель
    uint256 public totalAmount;
    address public treasury;      
    uint256 public startTime;
    uint256 public cliff;
    uint256 public duration;  
    uint256 public claimed;
    uint256 public claimCooldown;
    uint256 public minClaimAmount;

    //@notice user => last claim time
    mapping (address => uint256) public claimTime;


    error AlareadyInitialized();
    error ClaimerIsNotBeneficiary();
    error CliffNotReached();
    error NothingToClaim();
    error TransferFailed();
    error ClaimCooldown();
    error TooSmallClaim();

    event Claim(address beneficiary, uint256 amount, uint256 timestamp);

    modifier notInitialized() {
        require(!initialized, AlareadyInitialized());
        _;
    }        

    function claim() public {
        require(msg.sender == beneficiary, ClaimerIsNotBeneficiary());
        require(block.timestamp > startTime + cliff, CliffNotReached());
        require(claimTime[msg.sender] + claimCooldown < block.timestamp, ClaimCooldown());
        

        uint256 claimable = claimableAmount();
        require(claimable > 0, NothingToClaim());
        require(minClaimAmount >= claimable, TooSmallClaim());
        claimed += claimable;
        claimTime[msg.sender] = block.timestamp;
        require(token.transfer(beneficiary, claimable), TransferFailed());
        
        emit Claim(msg.sender, claimable, block.timestamp);
    }

    //vestedTime = currentTime-(startTime - cliff)
    function vestedAmount() internal view returns(uint256)  { // сколько начислено токенов
        if (block.timestamp < startTime + cliff) return 0;
        
        uint256 passedTime = block.timestamp - (startTime + cliff);
        return (totalAmount * passedTime) / duration;
    }

    
    function claimableAmount() public view returns(uint256) { // начислено - уже заклеймлено
        if (block.timestamp < startTime + cliff) return 0;
        return vestedAmount() - claimed;
    }
  
    
    //
    //берем tokenAddress, totalAmount,owner
    //startVesring- принимает все переменные в параметры
    function initialize(bytes memory _initData) notInitialized external returns(bool) {       
        (address _token, uint256 _amount, address _treasury, address _owner, uint256 _claimCooldown, uint256 _minClaimAmount)  = abi.decode(_initData, (address,uint256, address, address, uint256, uint256));
        
        token = IERC20(_token);
        claimCooldown = _claimCooldown;
        Ownable.transferOwnership(_owner);
        minClaimAmount = _minClaimAmount;
        treasury = _treasury;
        amount = _amount;
        initialized = true;

        return true;
    }     

    function getInitData(address _token, uint256 _amount, address _treasury, address _owner, uint256 _claimCooldown, uint256 _minClaimAmount) external pure returns(bytes memory ) {
        return abi.encode(_token, _amount, _treasury, _owner, _claimCooldown, _minClaimAmount);
        //claimCooldown
    }    



}