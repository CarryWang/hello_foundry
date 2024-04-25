// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";
import {NFTMarket} from "../src/MyNFTMarket.sol";
import {BaseERC20} from "../src/MyERC20.sol";
import {ERC721Mock} from "./mocks/ERC721Mock.sol";

contract MyNFTMarketTest is Test {
    NFTMarket public mkt;
    BaseERC20 public token;
    ERC721Mock public nftToken;
    address testUser = makeAddr("Carry");

    function setUp() public {
        token = new BaseERC20();
        nftToken = new ERC721Mock("CarryWang", "CW");
        mkt = new NFTMarket(address(token), address(nftToken));

        nftToken.mint(testUser, 1);
    }

    function testFail_needApproved() public {
        uint tokenId = 1;
        uint amount = 1000;
        vm.prank(testUser);
        mkt.list(tokenId, amount);
    }

    function test_listNFT() public {
        uint tokenId = 1;
        uint amount = 1000;

        vm.startPrank(testUser);
        // 调用list之前先approve
        nftToken.setApprovalForAll(address(mkt), true);

        mkt.list(tokenId, amount);
        vm.stopPrank();

        assertEq(mkt.tokenIdPrice(tokenId), amount);
        assertEq(mkt.tokenSeller(tokenId), testUser);
    }
}
