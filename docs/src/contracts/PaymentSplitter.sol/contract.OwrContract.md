# OwrContract
[Git Source](https://github.com/soliditydevMRF/deployer/blob/de05838bc462bc4add13a7335743c192f750e965/contracts\PaymentSplitter.sol)

**Inherits:**
VestingWallet


## Functions
### constructor


```solidity
constructor(address _beneficiary, uint64 _duration)
    payable
    VestingWallet(_beneficiary, uint64(block.timestamp), _duration);
```

