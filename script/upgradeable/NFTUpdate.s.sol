// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {NFTMarketV1} from "../../src/upgradeable/NFTMarketV1.sol";
import {NFTMarketV2} from "../../src/upgradeable/NFTMarketV2.sol";
import {NFTPermit} from "../../src/upgradeable/NFTPermit.sol";
import {TokenPermit} from "../../src/upgradeable/TokenPermit.sol";

import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract NFTUpdateScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        TokenPermit tokenPermit = new TokenPermit();
        NFTPermit nftPermit = new NFTPermit();

        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarketV1.sol:NFTMarketV1",
            msg.sender,
            abi.encodeCall(NFTMarketV1.initialize, (address(tokenPermit), address(nftPermit)))
        );

        Upgrades.upgradeProxy(proxy, "NFTMarketV2.sol:NFTMarketV2", "");

        vm.stopBroadcast();
    }
}
