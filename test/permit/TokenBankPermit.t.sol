// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "forge-std/Test.sol";
import {TokenPermit} from "../../src/permit/TokenPermit.sol";
import {TokenBankPermit} from "../../src/permit/TokenBankPermit.sol";

contract TokenBankPermitTest is Test {
    TokenPermit public tokenPermit;
    TokenBankPermit public tokenBankPermit;

    function setUp() public {
        address owner = makeAddr("owner");
        vm.prank(owner);
        tokenPermit = new TokenPermit();
        tokenBankPermit = new TokenBankPermit();
    }

    function test_permitDeposit() public {
        (address owner, uint256 ownerKey) = makeAddrAndKey("owner");
        address spender = address(tokenBankPermit);
        uint256 value = 100;
        uint256 nonce = tokenPermit.nonces(owner);
        uint256 deadline = block.timestamp * 2;

        // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
        bytes32 PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonce, deadline));

        bytes32 DOMAIN_SEPARATOR = tokenPermit.DOMAIN_SEPARATOR();
        bytes32 digest = keccak256(abi.encodePacked(hex"1901", DOMAIN_SEPARATOR, structHash));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerKey, digest);

        vm.startPrank(owner);
        tokenBankPermit.permitDeposit(address(tokenPermit), value, deadline, v, r, s);

        assertEq(tokenBankPermit.bankBalances(owner, address(tokenPermit)), value);

        vm.stopPrank();
    }
}
