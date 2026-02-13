# VestingLib
[Git Source](https://github.com/soliditydevMRF/deployer/blob/a09320562797b10f59bba6db450af6b99d45fbb4/contracts\Vesting\VestingLib.sol)

**Title:**
Vesting Library

Provides utility functions for calculating vested and claimable token amounts


## Functions
### vestedAmount

Calculates the total amount of tokens vested for a given vesting schedule at the current time


```solidity
function vestedAmount(IVesting.VestingInfo storage v) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`v`|`IVesting.VestingInfo`|The vesting information struct|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The total amount of tokens vested|


### claimableAmount

Calculates the amount of tokens currently claimable by the beneficiary


```solidity
function claimableAmount(IVesting.VestingInfo storage v) internal view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`v`|`IVesting.VestingInfo`|The vesting information struct|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The amount of tokens that can be claimed|


