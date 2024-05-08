// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract TokenPermit is ERC20Permit {
    constructor() ERC20("TokenPermit", "TP") ERC20Permit("TokenPermit") {
        _mint(msg.sender, 1024 * 10 ** 18);
    }
}
