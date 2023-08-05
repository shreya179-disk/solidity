// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract TimeLock{
    uint public StartTime;
    uint public LockTime =  30 seconds; // preventing  you from using your funds for 3 weeks
    address public owner ;
modifier onlyby(address _acc) {
  require(msg.sender == _acc, " Not Authorised");
  _;
   
}

constructor (){
    owner = msg.sender;
    StartTime = block.timestamp;
}
 function withdraw() public onlyby(owner) {
        require(block.timestamp >= StartTime + LockTime, "Lock period has not ended yet"); // blocktimestamp which is now should be greater than locktime to get your funds
        
       payable(owner).transfer(address(this).balance);

} 

}