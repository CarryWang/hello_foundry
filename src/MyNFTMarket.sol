// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "./MyERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IReceiver} from "./IReceiver.sol";

contract NFTMarket is IERC721Receiver, IReceiver {
    // nft的报价
    mapping(uint256 => uint256) public tokenIdPrice;
    // nft的出售者
    mapping(uint256 => address) public tokenSeller;
    address public immutable token;
    address public immutable nftToken;

    constructor(address _token, address _nftToken) {
        token = _token;
        nftToken = _nftToken;
    }

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // approve(address to, uint256 tokenId) first
    // 上架售卖 需先对nft的转移进行授权approve
    function list(uint256 tokenId, uint256 amount) external returns (bool) {
        // bytes memory data = abi.encode(amount);
        // 将nft转移至市场
        IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, "");
        // 记录售价
        tokenIdPrice[tokenId] = amount;
        // 记录卖家
        tokenSeller[tokenId] = msg.sender;

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

    function tokensReceived(address _from, uint256 amount, bytes calldata data) public returns (bool) {
        require(msg.sender == token, "invalid caller");

        uint256 tokenId = abi.decode(data, (uint256));

        require(tokenIdPrice[tokenId] <= amount, "payment value is less than list price");

        // token从市场转移给卖家
        IERC20(token).transfer(tokenSeller[tokenId], amount);
        // nft从市场转移给买家
        IERC721(nftToken).safeTransferFrom(address(this), _from, tokenId);
        return true;
    }
}
