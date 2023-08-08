// exchange contract facilitates all token swaps, or “trades.”
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract Exchange{
    address public tokenaddress;
    constructor(address _token){
        require(_token != address(0), "Invalid token address");// ethereum address 0 is a blank address
        tokenaddress =_token;
    }

    function addliquidity(uint256 _tokenamount) public payable {
        IERC20 token = IERC20(tokenaddress);// token variable to a specific erc20  contract
        token.transferFrom(msg.sender, address(this), _tokenamount);
    }
     
    function getreserve() public view returns(uint256){//returns token balance of an exchange.
        return IERC20(tokenaddress).balanceOf(address(this));
    }

    function getamount(uint256 inputamount, uint256 inputreserve, uint256 outputreserve) private pure returns(uint256){
        require(inputreserve > 0 && outputreserve > 0,"Insufficient Reserve");// &y = (y*&x)/(x+$x)
        return(inputamount*outputreserve/inputamount+inputreserve);
    }

    function gettokenamount(uint256 _ethSold) public view returns (uint256) {
        require(_ethSold > 0, "ethSold is too small");// the amount of tokens to be received in exchange of ethers.

        uint256 tokenreserve = getreserve();

        return getamount(_ethSold, address(this).balance, tokenreserve);
    }

    function getethamount(uint256 _tokenSold) public view returns (uint256){
        require(_tokenSold > 0, " tokenSold is too small");// the amount of ethers received in exchange of tokens
        uint256 tokenreserve = getreserve();

       return getamount(_tokenSold, address(this).balance, tokenreserve);
    }

    function ethtoTokenswap(uint _mintokens) public payable{
        uint tokenreserve = getreserve();
        uint tokenbought = getamount(msg.value, // swapping of the ether for tokens
           address(this).balance - msg.value,
           tokenreserve);
        require(tokenbought >= _mintokens, "insufficient output amount");

        IERC20(tokenaddress).transfer(msg.sender, tokenbought);
    }

    function tokentoEthswap(uint256 _tokensSold, uint256 _minethers) public{
        uint256 tokenreserve = getreserve();
        uint256 ethbought = getamount(_tokensSold,
            tokenreserve,
            address(this).balance);
        require(ethbought >= _minethers,"insufficient output amount");

        IERC20(tokenaddress).transferFrom(msg.sender, address(this), _tokensSold);
        payable(msg.sender).transfer(ethbought);
    }
}





