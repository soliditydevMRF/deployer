# IUtilityContract
[Git Source](https://github.com/soliditydevMRF/deployer/blob/a09320562797b10f59bba6db450af6b99d45fbb4/contracts\UtilityContract\IUtilityContract.sol)

**Inherits:**
IERC165

**Title:**
IUtilityContract - Interface for utility contracts

**Author:**
Solidity University

This interface defines the functions and events for utility contracts.

Utility contracts should implement this interface to be compatible with the DeployManager.


## Functions
### initialize

Initializes the utility contract with the provided data

This function should be called by the DeployManager after deploying the contract


```solidity
function initialize(bytes memory _initData) external returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|The initialization data for the utility contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the initialization was successful|


### getDeployManager


```solidity
function getDeployManager() external view returns (address);
```

## Errors
### DeployManagerCannotBeZero
Reverts if the deploy manager is not set or is invalid


```solidity
error DeployManagerCannotBeZero();
```

### NotDeployManager

```solidity
error NotDeployManager();
```

### FailedToDeployManager

```solidity
error FailedToDeployManager();
```

### AlreadyInitialized

```solidity
error AlreadyInitialized();
```

