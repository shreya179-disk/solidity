//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//v1 supporting ether-token swaps.
contract Token is ERC20{
  constructor(
    string memory name,
    string memory symbol,
    uint256 intialsupply
  ) ERC20(name, symbol) { // constructor expects these variables when the contract is deployed.
    _mint(msg.sender, intialsupply);// function present in the erc20 contract
  }
}



