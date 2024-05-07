// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    uint256 public tokenIds = 1;

    constructor() ERC721("CarryNFT", "CNFT") {}

    function mint() public returns (uint256) {
        uint256 newItemId = tokenIds;
        _mint(msg.sender, newItemId);
        tokenIds++;

        return newItemId;
    }
}
