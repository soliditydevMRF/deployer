# OwrContract
[Git Source](https://github.com/soliditydevMRF/deployer/blob/a09320562797b10f59bba6db450af6b99d45fbb4/contracts\PaymentSplitter.sol)

**Inherits:**
VestingWallet


## Functions
### constructor


```solidity
constructor(address _beneficiary, uint64 _duration)
    payable
    VestingWallet(_beneficiary, uint64(block.timestamp), _duration);
```

