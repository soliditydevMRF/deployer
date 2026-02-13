# ERC721Airdroper
[Git Source](https://github.com/soliditydevMRF/deployer/blob/a09320562797b10f59bba6db450af6b99d45fbb4/contracts\ERC721Airdroper\ERC721Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](\contracts\UtilityContract\AbstractUtilityContract.sol\abstract.AbstractUtilityContract.md), Ownable


## State Variables
### MAX_AIRDROP_BATCH_SIZE

```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300
```


### token

```solidity
IERC721 public token
```


### treasury

```solidity
address public treasury
```


## Functions
### constructor


```solidity
constructor() payable Ownable(msg.sender);
```

### airdrop


```solidity
function airdrop(address[] calldata receivers, uint256[] calldata tokenIds) external onlyOwner;
```

### initialize


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```

### getInitData


```solidity
function getInitData(address _deployManager, address _token, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```

## Errors
### ArraysLengthMismatch

```solidity
error ArraysLengthMismatch();
```

### NeedToApproveTokens

```solidity
error NeedToApproveTokens();
```

### BatchSizeExceeded

```solidity
error BatchSizeExceeded();
```

