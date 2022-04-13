# Copy this to your MyArtNFT.sol

```sol
// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;


import "https://github.com/nibbstack/erc721/src/contracts/tokens/nf-token-metadata.sol";

import "https://github.com/nibbstack/erc721/src/contracts/ownership/ownable.sol";
 
contract MyArtNFT is NFTokenMetadata, Ownable {
 
  constructor() {
    nftName = "My Art NFT";
    nftSymbol = "MART";
  }
 
  function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
    super._mint(_to, _tokenId);
    super._setTokenUri(_tokenId, _uri);
  }
 
}
```
