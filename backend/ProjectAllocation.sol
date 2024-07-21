// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ProjectAllocation is Ownable {
    using SafeMath for uint256;

    uint256 public totalAllowance;
    mapping(address => uint256) public userAllocations;
    mapping(uint256 => uint256) public projectAllocations;

    event AllocationMade(address indexed user, uint256 indexed projectId, uint256 amount);

    constructor(uint256 _totalAllowance) {
        totalAllowance = _totalAllowance;
    }

    function allocateFunds(uint256 projectId, uint256 amount) public {
        require(userAllocations[msg.sender].add(amount) <= totalAllowance, "Exceeds total allowance");
        userAllocations[msg.sender] = userAllocations[msg.sender].add(amount);
        projectAllocations[projectId] = projectAllocations[projectId].add(amount);
        emit AllocationMade(msg.sender, projectId, amount);
    }

    function getProjectAllocation(uint256 projectId) public view returns (uint256) {
        return projectAllocations[projectId];
    }

    function setTotalAllowance(uint256 _totalAllowance) public onlyOwner {
        totalAllowance = _totalAllowance;
    }
}
