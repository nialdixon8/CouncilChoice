// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ProjectAllocation is Ownable {
    uint256 public totalAllowance;
    mapping(address => uint256) public userAllocations;
    mapping(uint256 => uint256) public projectAllocations;

    event AllocationMade(address indexed user, uint256 indexed projectId, uint256 amount);

    constructor(address _owner, uint256 _totalAllowance) Ownable(_owner) {
        totalAllowance = _totalAllowance;
    }

    function allocateFunds(uint256 projectId, uint256 amount) public {
        require(userAllocations[msg.sender] + amount <= totalAllowance, "Exceeds total allowance");
        userAllocations[msg.sender] += amount;
        projectAllocations[projectId] += amount;
        emit AllocationMade(msg.sender, projectId, amount);
    }

    function getProjectAllocation(uint256 projectId) public view returns (uint256) {
        return projectAllocations[projectId];
    }

    function setTotalAllowance(uint256 _totalAllowance) public onlyOwner {
        totalAllowance = _totalAllowance;
    }
}
