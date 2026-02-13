# OwrContract
[Git Source](https://github.com/soliditydevMRF/deployer/blob/8499770d06a733e0c27d8fd08b712f55d4c32740/contracts\PaymentSplitter.sol)

**Inherits:**
VestingWallet


## Functions
### constructor


```solidity
constructor(address _beneficiary, uint64 _duration)
    payable
    VestingWallet(_beneficiary, uint64(block.timestamp), _duration);
```

