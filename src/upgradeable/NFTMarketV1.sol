// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract NFTMarketV1 is Initializable {
    mapping(uint256 => uint256) public tokenIdPrice;
    mapping(uint256 => address) public tokenSeller;
    address public token;
    address public nftToken;

    function initialize(address _token, address _nftToken) public initializer {
        token = _token;
        nftToken = _nftToken;
    }

    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function list(uint256 tokenId, uint256 amount) external returns (bool) {
        // bytes memory data = abi.encode(amount);

        IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, "");

        tokenIdPrice[tokenId] = amount;

        tokenSeller[tokenId] = msg.sender;

        return true;
    }

    function permitBuy(uint256 tokenId, address user, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
        external
        returns (bool)
    {
        IERC20Permit(token).permit(user, address(this), amount, deadline, v, r, s);

        buy(tokenId, amount);

        return true;
    }

    function buy(uint256 tokenId, uint256 amount) public returns (bool) {
        require(amount >= tokenIdPrice[tokenId], "low price");
        // 检查nft是否已经售卖
        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "aleady selled");

        // 需先对token的转移进行授权，转移资金给卖家
        IERC20(token).transferFrom(msg.sender, tokenSeller[tokenId], tokenIdPrice[tokenId]);
        // nft从市场转移给买家
        IERC721(nftToken).transferFrom(address(this), msg.sender, tokenId);

        return true;
    }
}
