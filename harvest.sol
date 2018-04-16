//*************** Time Locked based smart contract*********
//      1. contract creator is admin
//      2. any funds sent to contract address stays locked for n number of days(in this case 10 days)
//      3. Funds can be withdrawn after time limit expires 
//      4. funds are sent to the admin/creator of the smart contract

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
    
    //receive funds from any address
    function() public payable {
        
    }
    
    //return funds only to admin
    function withdraw() public onlyAdmin {
        require (block.timestamp > harvest);
        msg.sender.transfer(address(this).balance);
    }
    
    // incase anything comes up admin is able to kill contract and retrive funds
    function kill() public onlyAdmin {
        selfdestruct(admin);
    }
    
}
