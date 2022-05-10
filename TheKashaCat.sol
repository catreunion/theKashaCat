// SPDX-License-Identifier: MIT
// contract address via Remix:
// contract address via Hardhat: 0xdA5B8A7db2d47F593C8217c4e9A65a35A4C17a6F
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TheKashaCat is ERC721, ERC721Enumerable, ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIdCounter;
  uint256 MAX_SUPPLY = 10000;

  // In OpenSea, the token name will be used as the collection name
  constructor() ERC721("The Kasha Cat", "TKC") {}

  // _tokenURI : need to be resolving to a JSON document that describes the NFT's metadata
  // such as ipfs://bafkreig4rdq3nvyg2yra5x363gdo4xtbcfjlhshw63we7vtlldyyvwagbq
  function safeMint(address _to, string memory _tokenURI) public {
    _tokenIdCounter.increment();
    // ID of the 1st NFT = 1
    uint256 tokenId = _tokenIdCounter.current();

    require(tokenId <= MAX_SUPPLY, "All NFTs have been minted");
    _safeMint(_to, tokenId);
    _setTokenURI(tokenId, _tokenURI);
  }

  function _beforeTokenTransfer(
    address _from,
    address _to,
    uint256 _tokenId
  ) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(_from, _to, _tokenId);
  }

  function _burn(uint256 _tokenId) internal override(ERC721, ERC721URIStorage) {
    super._burn(_tokenId);
  }

  // return a URI where OpenSea can find the metadata
  function tokenURI(uint256 _tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
    return super.tokenURI(_tokenId);
  }

  function supportsInterface(bytes4 _interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
    return super.supportsInterface(_interfaceId);
  }
}

// ❯ yarn hardhat run scripts/Alchemy/TheKashaCat.js --network polygon
// contract address: 0xdA5B8A7db2d47F593C8217c4e9A65a35A4C17a6F

// ❯ yarn hardhat verify 0xdA5B8A7db2d47F593C8217c4e9A65a35A4C17a6F --network polygon
// Successfully submitted source code for contract
// contracts/Alchemy/TheKashaCat.sol:TheKashaCat at 0xdA5B8A7db2d47F593C8217c4e9A65a35A4C17a6F
// Successfully verified contract TheKashaCat on Etherscan.
// https://polygonscan.com/address/0xdA5B8A7db2d47F593C8217c4e9A65a35A4C17a6F#code
