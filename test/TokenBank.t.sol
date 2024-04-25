// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {TokenBank} from "../src/TokenBank.sol";
import {BaseERC20} from "../src/MyERC20.sol";

contract TokenBankTest is Test {
    TokenBank public bank;
    BaseERC20 public token;
    address testUser = makeAddr("Carry");

    function setUp() public {
        vm.startPrank(testUser);
        token = new BaseERC20();

        bank = new TokenBank(address(token));

        token.transfer(address(bank), 10000);
        token.transfer(address(testUser), 10000);

        vm.stopPrank();
    }

    function test_deposit() public {
        uint amount = 1000;

        vm.startPrank(testUser);
        token.approve(address(bank), 10000);
        bank.deposit(amount);
        vm.stopPrank();
        // console.log(bank.bankBalances(testUser));

        assertEq(bank.bankBalances(testUser), amount);
    }

    function test_withdraw() public {
        test_deposit();

        uint amount = 1000;

        vm.startPrank(testUser);
        bank.withdraw(amount);
        vm.stopPrank();

        assertEq(bank.bankBalances(testUser), 0);
    }
}
