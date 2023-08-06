// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTokens {
    string public name;
    string public symbol;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;  //his two-dimensional mapping is used to represent allowances granted by one address (the owner) to another address (the spender) for spending a certain number of tokens on their behalf.

    constructor(string memory baps, string memory badps25, uint256 initialSupply) {
        name = baps;
        symbol = badps25;
        totalSupply = initialSupply;
        balanceOf[msg.sender] = totalSupply;
    }
     function transfer(address to, uint256 value) external {
        require(to != address(0), "Invalid recipient");
        require(value <= balanceOf[msg.sender], "Insufficient balance");
          balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to);
        
     }