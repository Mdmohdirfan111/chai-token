// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChaiToken is ERC20, Ownable {
    uint256 public constant TAX_RATE = 200; // 2% tax
    address public constant TREASURY = 0xEF253F8E8839fe1E34159c7301078cc490aad7E2;

    constructor() ERC20("Chai Token", "CHAI") Ownable(msg.sender) {
        _mint(msg.sender, 10_000_000 * 10**18);
    }

    function _update(address from, address to, uint256 amount) internal override {
        if (from != address(0) && to != address(0) && from != TREASURY) {
            uint256 tax = (amount * TAX_RATE) / 10_000;
            super._update(from, TREASURY, tax);
            amount -= tax;
        }
        super._update(from, to, amount);
    }
}
