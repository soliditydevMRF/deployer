// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import {IUtilityContract} from "../UtilityContract/IUtilityContract.sol";
import "./IDeployManager.sol";

contract DeployManager is IDeployManager, Ownable, ERC165 {
    error ContractNotActive();
    error NotEnoughtFunds();
    error ContractDoesNotRegistered();
    error InitializationFailed();

    constructor() payable Ownable(msg.sender) {}

    struct ContractInfo {
        uint256 fee;
        bool isActive;
        uint256 registeredAt;
    }
    //@notice user  =>   contracts[]
    mapping(address => address[]) public deployedContracts;
    //@notice contract address => info
    mapping(address => ContractInfo) public contractsData;

    function deploy(address _utilityContract, bytes calldata _initData) external payable override returns (address) {
        ContractInfo memory info = contractsData[_utilityContract];
        require(info.isActive, ContractNotActive());
        require(msg.value >= info.fee, NotEnoughtFunds());
        require(info.registeredAt > 0, ContractDoesNotRegistered());

        address clone = Clones.clone(_utilityContract); //адрес нового контракта

        require(IUtilityContract(clone).initialize(_initData), InitializationFailed());

        payable(owner()).transfer(msg.value);

        deployedContracts[msg.sender].push(clone);

        emit NewDeployment(msg.sender, clone, msg.value, block.timestamp);

        return clone;
    }

    function addNewContract(address _contractAddress, uint256 _fee, bool _isActive) external override onlyOwner {
        contractsData[_contractAddress] = ContractInfo({fee: _fee, isActive: _isActive, registeredAt: block.timestamp});

        emit NewContractAdded(_contractAddress, _fee, _isActive, block.timestamp);
    }

    function updateFee(address _contractAddress, uint256 _newFee) external override onlyOwner {
        require(contractsData[_contractAddress].registeredAt > 0, ContractDoesNotRegistered());
        uint256 _oldFee = contractsData[_contractAddress].fee;
        contractsData[_contractAddress].fee = _newFee;

        emit ContractFeeUpdated(_contractAddress, _oldFee, _newFee, block.timestamp);
    }

    function deactivateContract(address _address) external override onlyOwner {
        require(contractsData[_address].registeredAt > 0, ContractDoesNotRegistered());
        contractsData[_address].isActive = false;
        emit ContractStatusUpdated(_address, false, block.timestamp);
    }

    function activateContract(address _address) external override onlyOwner {
        require(contractsData[_address].registeredAt > 0, ContractDoesNotRegistered());
        contractsData[_address].isActive = true;
        emit ContractStatusUpdated(_address, true, block.timestamp);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC165) returns (bool) {
        return interfaceId == type(IUtilityContract).interfaceId || super.supportsInterface(interfaceId);
    }
}

// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 owner

//0xB098aE7ddc405A6a6F891693e00c8B9895e1a93f deploy

//0xd457540c3f08f7F759206B5eA9a4cBa321dE60DC airdroper

//0xc6b336BE77D9A30776f044375A96224303d07F03 new aidroper
