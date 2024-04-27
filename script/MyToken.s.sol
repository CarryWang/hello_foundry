// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenScript is Script {
    function setUp() public {}

    function run() public {
        address Carry = 0xa0466a82B961e85077d4a8DEBC35fbF6Cf18D464;

        vm.startBroadcast(Carry);

        MyToken myToken = new MyToken("CarryCoin", "CC");

        myToken.mint(100);

        vm.stopBroadcast();

        // forge script script/MyToken.s.sol:MyTokenScript --rpc-url https://1rpc.io/sepolia --broadcast --verify -vvvv
    }
}
