// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface IERC721Permit {
    function permit(address owner, address spender, uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s)
        external;
}

contract NFTPermit is ERC721 {
    uint256 public tokenIds = 1;

    constructor() ERC721("CarryNFT", "CNFT") {}

    function mint() public returns (uint256) {
        uint256 newItemId = tokenIds;
        _mint(msg.sender, newItemId);
        tokenIds++;

        return newItemId;
    }

    // 在nft市场里做permit
    // function permit(address owner, address spender, uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s)
    //     external
    // {
    //     bytes32 PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 tokenId,uint256 price)");

    //     bytes32 digest =
    //         keccak256(abi.encodePacked(keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, tokenId, price))));

    //     address signer = ecrecover(digest, v, r, s);

    //     if (signer != owner) {
    //         revert("Invalid signer!!!");
    //     }

    //     _setApprovalForAll(owner, spender, true);
    // }
}
