// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";

import {NFTMarketV1} from "../../src/upgradeable/NFTMarketV1.sol";
import {NFTMarketV2} from "../../src/upgradeable/NFTMarketV2.sol";
import {NFTPermit} from "../../src/upgradeable/NFTPermit.sol";
import {TokenPermit} from "../../src/upgradeable/TokenPermit.sol";

import {Upgrades, Options} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract NFTUpdateTest is Test {
    TokenPermit public tokenPermit;
    NFTPermit public nftPermit;
    NFTMarketV1 public nftMktV1;
    NFTMarketV2 public nftMktV2;

    address public admin = makeAddr("admin");

    function setUp() public {
        tokenPermit = new TokenPermit();
        nftPermit = new NFTPermit();
    }

    function test_upgrade_to_v2() public {
        Options memory opts;
        opts.unsafeSkipAllChecks = true;

        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarketV1.sol:NFTMarketV1",
            admin,
            abi.encodeCall(NFTMarketV1.initialize, (address(tokenPermit), address(nftPermit)))
        );

        nftMktV1 = NFTMarketV1(proxy);

        (address seller, uint256 sellerKey) = makeAddrAndKey("seller");

        vm.startPrank(seller);

        uint256 nftId = nftPermit.mint();
        uint256 nftIdPrice = 100;
        nftPermit.setApprovalForAll(address(nftMktV1), true);
        nftMktV1.list(nftId, nftIdPrice);

        vm.stopPrank();

        assertEq(nftMktV1.tokenIdPrice(nftId), nftIdPrice);
        assertEq(nftMktV1.tokenSeller(nftId), seller);

        console.log(seller, "seller");

        vm.startPrank(admin);
        Upgrades.upgradeProxy(proxy, "NFTMarketV2.sol:NFTMarketV2", "");
        vm.stopPrank();

        nftMktV2 = NFTMarketV2(proxy);
        assertEq(nftMktV2.tokenIdPrice(nftId), 100);
        assertEq(nftMktV2.tokenSeller(nftId), seller);

        vm.startPrank(seller);
        uint256 nftId2 = nftPermit.mint();
        uint256 nftId2Price = 200;

        console.log(nftId2);
        console.log(nftPermit.ownerOf(nftId2));

        bytes32 digest = keccak256(
            abi.encodePacked(
                keccak256(abi.encode(keccak256("PermitList(uint256 tokenId,uint256 amount)"), nftId2, nftId2Price))
            )
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(sellerKey, digest);

        nftMktV2.permitList(nftId2, nftId2Price, v, r, s);
        vm.stopPrank();

        assertEq(nftMktV2.tokenIdPrice(nftId2), nftId2Price);
        assertEq(nftMktV2.tokenSeller(nftId2), seller);
    }
}
