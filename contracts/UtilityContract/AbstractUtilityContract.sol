//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {IDeployManager} from "../DeployManager/IDeployManager.sol";
import {IUtilityContract} from "./IUtilityContract.sol";

abstract contract AbstractUtilityContract is IUtilityContract, ERC165 {
    address public deployManager;

    function initialize(bytes memory _initData) external virtual override returns (bool) {
        deployManager = abi.decode(_initData, (address));
        return true;
    }

    function setDeployManager(address _deployManager) external virtual override {}

    function validateDeployManager(address _deployManager) internal pure returns (bool) {
        if (_deployManager == address(0)) {
            revert DeployManagerCantBeZero();
        }
        return true;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC165) returns (bool) {
        return interfaceId == type(IUtilityContract).interfaceId || super.supportsInterface(interfaceId);
    }
}

