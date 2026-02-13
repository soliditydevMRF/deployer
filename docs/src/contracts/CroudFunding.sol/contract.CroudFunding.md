# CroudFunding
[Git Source](https://github.com/soliditydevMRF/deployer/blob/de05838bc462bc4add13a7335743c192f750e965/contracts\CroudFunding.sol)

**Inherits:**
VestingWallet


## State Variables
### goal

```solidity
uint256 goal
```


### fundraiser

```solidity
address fundraiser
```


### vestingDuration

```solidity
uint256 vestingDuration
```


### initialized

```solidity
bool private initialized
```


## Functions
### constructor


```solidity
constructor(address _beneficiary, uint64 _duration)
    payable
    VestingWallet(_beneficiary, uint64(block.timestamp), _duration);
```

### initialize


```solidity
function initialize(bytes memory _initData) external returns (bool);
```

### getInitData


```solidity
function getInitData(uint256 _goal, address _fundraiser, uint256 _vestingDuration, address _owner)
    external
    pure
    returns (bytes memory);
```

