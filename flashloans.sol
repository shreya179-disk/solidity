// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IFlashLoanReceiver {
    function execute() external;
}

contract FlashLoanProvider {
    using SafeERC20 for IERC20;

    address public owner;
    IERC20 public token;

    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = IERC20(_tokenAddress);
    }