// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";

import "../../src/proxy/InscriptionFactory.sol";

contract InscriptionFactoryTest is Test {
    InscriptionFactory public inscriptionFactory;
    address public creator;
    address public factoryOwner;
    address public tokenAddress;

    function setUp() public {
        creator = makeAddr("creator");
        factoryOwner = makeAddr("factoryowner");

        vm.prank(factoryOwner);
        inscriptionFactory = new InscriptionFactory();

        vm.prank(creator);
        tokenAddress = inscriptionFactory.deployInscription(10000, 1, 100);
    }

    function test_mint_inscription() public {
        vm.deal(creator, 100);

        vm.prank(creator);
        inscriptionFactory.mintInscription{value: 100}(tokenAddress);

        console.log(creator.balance, "creator.balance");
        assertEq(creator.balance, 95);
        assertEq(factoryOwner.balance, 5);
    }
}
