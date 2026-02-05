// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/interfaces/IERC165.sol";

interface IUtilityContract is IERC165 {
    error DeployManagerCantBeZero();
    error NotDeployManager();

    function initialize(bytes memory _initData) external returns (bool);

    function setDeployManager(address _deployManager) external;
}
//
