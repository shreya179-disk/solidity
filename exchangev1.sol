// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";//idk
contract Exchange{
    address public tokenaddress;
    constructor(address _token){
        require(_token != address(0), "Invalid token address");// ethereum address 0 is a blank address
        tokenaddress =_token;
    }

    function addliquidity(uint256 _tokenamount) public payable {
        IERC20 token = IERC20(tokenaddress);// token variable to specific erc contract
        token.transferFrom(msg.sender, address(this), _tokenamount);
    }
     
     function getbalance() public view returns(uint256){
        return IERC20(tokenaddress).balanceOf(address(this));
     }
}





