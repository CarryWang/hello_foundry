// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Inscription.sol";

contract InscriptionFactory {
    using Clones for address;

    address public impl;
    address public factoryOwner;
    address public creator;

    mapping(address token => bool isDeployed) public deployedTokens;

    constructor() {
        impl = address(new Inscription());
        factoryOwner = msg.sender;
    }

    function deployInscription(uint256 totalSupply, uint256 perMint, uint256 price) public returns (address) {
        creator = msg.sender;
        address clone = impl.clone();
        Inscription(clone).initialize(totalSupply, perMint, price, msg.sender, factoryOwner);
        deployedTokens[clone] = true;

        return clone;
    }

    function mintInscription(address tokenAddr) public payable returns (bool) {
        require(deployedTokens[tokenAddr], "token already deployed");
        Inscription(tokenAddr).mint(msg.sender);

        uint256 feeToCreator = (msg.value * 95) / 100;
        uint256 feeToFactoryOwner = (msg.value * 5) / 100;

        (bool successCreator,) = creator.call{value: feeToCreator}("");
        (bool successFactoryOwner,) = factoryOwner.call{value: feeToFactoryOwner}("");

        return successCreator && successFactoryOwner;
    }
}
