pragma solidity ^0.4.11;

contract timeDelay {
    
    address private admin;
    
    uint public seed;
    uint public harvest;
    
    
    // constructor
    function timeDelay() public {
        admin = msg.sender;
        seed = now;
        harvest = (seed + 10 days);
    }
    
    // modifier 
    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }
    
    function() public payable {
        
    }
    
    function withdraw() public onlyAdmin {
        require (block.timestamp > harvest);
        msg.sender.transfer(address(this).balance);
    }
    
}