// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAttacker {
  function onAppend() external returns (bool);
}

contract Target {
  uint256 public myStorage = 0;
  uint256 public maxSupply = 20;

  function append(address to, uint256 number) public returns (bool) {
    require(getLength() < maxSupply, "limit exceed, 1");
    require(number > 0, "number of <= 0");
    require(number <= 20, "number of > 0");
    require(getLength() + number <= maxSupply, "limit exceed, 2");

    for (uint256 i = 0; i < number; i++) {
      // as _safeMint
      myStorage++;
      require(IAttacker(to).onAppend(), "Boom");
    }
    return true;
  }

  function getLength() public view returns (uint256) {
    return myStorage;
  }
}
