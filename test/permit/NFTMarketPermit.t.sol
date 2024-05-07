// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";

import {MyNFT} from "../../src/permit/NFT.sol";
import {TokenPermit} from "../../src/permit/TokenPermit.sol";
import {NFTMarketPermit} from "../../src/permit/NFTMarketPermit.sol";

contract NFTMarketPermitTest is Test {
    MyNFT public myNFT;
    TokenPermit public tokenPermit;
    NFTMarketPermit public nftMarketPermit;

    function setUp() public {
        address seller = makeAddr("seller");
        address buyer = makeAddr("buyer");

        console.log(seller, "seller");
        console.log(buyer, "buyer");

        vm.prank(seller);
        myNFT = new MyNFT();

        vm.startPrank(buyer);
        tokenPermit = new TokenPermit();
        nftMarketPermit = new NFTMarketPermit(address(tokenPermit), address(myNFT));
        vm.stopPrank();
    }

    function test_permit_buy() public {
        address seller = makeAddr("seller");
        vm.startPrank(seller);
        uint256 nftId = myNFT.mint();
        myNFT.approve(address(nftMarketPermit), nftId);

        console.log(myNFT.ownerOf(nftId), "ownerOf");

        nftMarketPermit.list(nftId, 100);
        assertEq(nftMarketPermit.tokenIdPrice(nftId), 100);
        assertEq(nftMarketPermit.tokenSeller(nftId), seller);
        vm.stopPrank();

        // permit
        (address buyer, uint256 buyerKey) = makeAddrAndKey("buyer");
        address spender = address(nftMarketPermit);
        uint256 value = 100;
        uint256 nonce = tokenPermit.nonces(buyer);
        uint256 deadline = block.timestamp * 2;

        // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
        bytes32 PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, buyer, spender, value, nonce, deadline));

        bytes32 DOMAIN_SEPARATOR = tokenPermit.DOMAIN_SEPARATOR();
        bytes32 digest = keccak256(abi.encodePacked(hex"1901", DOMAIN_SEPARATOR, structHash));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(buyerKey, digest);

        vm.prank(buyer);
        nftMarketPermit.permitBuy(nftId, buyer, value, deadline, v, r, s);

        console.log(myNFT.ownerOf(nftId), "ownerOf");
        assertEq(myNFT.ownerOf(nftId), buyer);

        // 未permit情况下的测试
        address buyerNoPermit = makeAddr("buyerNoPermit");
        vm.prank(buyerNoPermit);
        vm.expectRevert();
        nftMarketPermit.permitBuy(nftId, buyerNoPermit, value, deadline, v, r, s);
    }
}
