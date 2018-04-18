//*************** Time Locked based smart contract*********
//      1. contract creator is admin
//      2. any funds sent to contract address stays locked for n number of days(in this case 10 days)
//      3. Funds can be withdrawn after time limit expires 
//      4. funds are sent to the admin/creator of the smart contract

pragma solidity ^0.4.11;

contract timeDelay {
    
    address private admin;
    
    struct seed_data {
        uint fund;
        uint harvest_time;
        uint seed;
    }
    
    mapping (address => seed_data) public seedInfo;
    
    // constructor
    function timeDelay() public {
        admin = msg.sender;
    }
    
    // modifier 
    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }
    
    function() public payable {
        
        uint amount = msg.value;
        
        seedInfo[msg.sender].fund = amount;
        seedInfo[msg.sender].harvest_time = 10 days;
        seedInfo[msg.sender].seed = now;
    }
    
    function withdraw() public {
        require (block.timestamp > (seedInfo[msg.sender].seed + seedInfo[msg.sender].harvest_time) );
        msg.sender.transfer(seedInfo[msg.sender].fund);
        seedInfo[msg.sender].fund = 0;
    }
    
    function showLockedFunds() constant public returns (uint x) {
        return seedInfo[msg.sender].fund;
    }
    
    
    function kill() public onlyAdmin {
        selfdestruct(admin);
    }
    
    
}
