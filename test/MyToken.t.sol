// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken internal myToken;
    address internal alice = makeAddr("alice");
    address internal bob = makeAddr("bob");

    function setUp() external {
        vm.prank(alice);
        myToken = new MyToken();
    }

    function testMint() external {
        vm.prank(alice);
        myToken.mint(1);

        assertEq(myToken.balanceOf(alice), 1);
    }

    function testFail_mint() external {
        vm.prank(bob);
        myToken.mint(1);
    }
}
