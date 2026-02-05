//SPDX-License-Identifier: MIT
    pragma solidity ^0.8.29;

    import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
    import "../IUtilityContract.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract ERC1155Airdroper is IUtilityContract, Ownable {
        constructor() Ownable(msg.sender) {}

        uint256 constant public MAX_AIRDROP_BATCH_SIZE = 10;

        IERC1155 public token;
        address public treasury;

        error AlareadyInitialized();
        error ResieversLengthMismatch();
        error NeedToApproveTokens();
        error TransferFailed();
        error AmountsLengthMismatch();
        error BatchSizeExceeded();

        modifier notInitialized() {
            require(!initialized, AlareadyInitialized());
            _;
        }

        bool private initialized;

        function initialize(bytes memory _initData) external notInitialized returns (bool) {
            (address _token, address _treasury, address _owner) = abi.decode(_initData, (address, address, address));

            token = IERC1155(_token);
            treasury = _treasury;
            Ownable.transferOwnership(_owner);

            initialized = true;

            return true;
    }

    function airdrop(address[] calldata _receivers, uint256[] calldata _amounts, uint256[] calldata tokenIds)
        external
        onlyOwner
    {
        require(tokenIds.length <= MAX_AIRDROP_BATCH_SIZE, BatchSizeExceeded());
        require(_receivers.length == tokenIds.length, ResieversLengthMismatch());
        require(_amounts.length == tokenIds.length, AmountsLengthMismatch());
        require(token.isApprovedForAll(treasury, address(this)), NeedToApproveTokens());

        for (uint256 i = 0; i < _amounts.length; i++) {
            token.safeTransferFrom(treasury, _receivers[i], tokenIds[i], _amounts[i], "");
        }
    }

    function getInitData(address _token, address _treasury, address _owner) external pure returns (bytes memory) {
        return abi.encode(_token, _treasury, _owner);
    }
}
// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]

