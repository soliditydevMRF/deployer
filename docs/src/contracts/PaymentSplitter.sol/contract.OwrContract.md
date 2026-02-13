# OwrContract
[Git Source](https://github.com/soliditydevMRF/deployer/blob/e837b8704d49077f8963a7804ac5b3b4098faa65/contracts\PaymentSplitter.sol)

**Inherits:**
VestingWallet


## Functions
### constructor


```solidity
constructor(address _beneficiary, uint64 _duration)
    payable
    VestingWallet(_beneficiary, uint64(block.timestamp), _duration);
```

