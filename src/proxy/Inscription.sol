// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Inscription is ERC20 {
    uint256 public totalInscription;
    uint256 public perMint;
    uint256 public price;
    uint256 public totalMinted;

    address public creator;
    address public factoryOwner;

    constructor() ERC20("Inscription", "IT") {}

    function initialize(uint256 _totalSupply, uint256 _perMint, uint256 _price, address _creator, address _factoryOwner)
        external
        returns (bool)
    {
        totalInscription = _totalSupply;
        perMint = _perMint;
        price = _price;
        creator = _creator;
        factoryOwner = _factoryOwner;

        return true;
    }

    function mint(address minter) external payable {
        require(msg.value == price, "wrong price");
        require(totalMinted + perMint <= totalInscription, "Max mint");

        uint256 feeToCreator = (msg.value * 95) / 100;
        uint256 feeToFactoryOwner = (msg.value * 5) / 100;

        payable(creator).transfer(feeToCreator);
        payable(factoryOwner).transfer(feeToFactoryOwner);

        _mint(minter, perMint);
        totalMinted += perMint;
    }
}
