// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DH_Token is ERC20Burnable, Ownable {
    error DH_Token__InsufficientBalance();
    error DH_Token__CannotHandleZero();
    error DH_Token__NonValidAddress();

    constructor() ERC20("Decentralized MAD", "DMAD") Ownable(msg.sender) {}

    function burn(uint _amount) public override onlyOwner {
        if (_amount > balanceOf(msg.sender))
            revert DH_Token__InsufficientBalance();
        if (_amount <= 0) revert DH_Token__CannotHandleZero();

        super.burn(_amount);
    }

    function mint(address _to, uint _amount) external onlyOwner returns (bool) {
        if (_to == address(0)) revert DH_Token__NonValidAddress();
        if (_amount <= 0) revert DH_Token__CannotHandleZero();
        _mint(_to, _amount);
        return true;
    }
}
