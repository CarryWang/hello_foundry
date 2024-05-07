// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

contract TokenBankPermit {
    mapping(address depositor => mapping(address token => uint256 value)) public bankBalances;

    function permitDeposit(address token, uint256 _value, uint256 _deadline, uint8 v, bytes32 r, bytes32 s) external {
        IERC20Permit(token).permit(msg.sender, address(this), _value, _deadline, v, r, s);

        deposit(token, _value);
    }

    function deposit(address token, uint256 _value) public returns (bool) {
        IERC20(token).transferFrom(msg.sender, address(this), _value);

        bankBalances[msg.sender][token] += _value;

        return true;
    }

    function withdraw(address token, uint256 _value) public returns (bool) {
        require(bankBalances[msg.sender][token] >= _value, "Insufficient balance");
        IERC20(token).transfer(msg.sender, _value);

        bankBalances[msg.sender][token] -= _value;

        return true;
    }
}
