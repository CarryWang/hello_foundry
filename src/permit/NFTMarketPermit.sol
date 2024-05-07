// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract NFTMarketPermit is IERC721Receiver {
    // nft的报价
    mapping(uint256 => uint256) public tokenIdPrice;
    // nft的出售者
    mapping(uint256 => address) public tokenSeller;
    address public immutable token;
    address public immutable nftToken;

    address public whiteListSigner;

    constructor(address _token, address _nftToken) {
        token = _token;
        nftToken = _nftToken;
        whiteListSigner = msg.sender;
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

    function permitBuy(uint256 tokenId, address user, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
        external
        returns (bool)
    {
        // require(user == "白名单地址");
        require(whiteListSigner == user, "only whiteListSigner");
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
