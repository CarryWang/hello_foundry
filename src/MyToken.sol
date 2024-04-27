// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

error NotMinter();

contract MyToken is ERC20 {
    address public immutable minter;

    constructor() ERC20("CarryCoin", "CC") {
        minter = msg.sender;
    }

    function mint(uint256 amount) external {
        if (msg.sender != minter) revert NotMinter();
        _mint(minter, amount);
    }
}
