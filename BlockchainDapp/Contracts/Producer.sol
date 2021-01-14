pragma solidity ^0.7.0;

contract Ownable {
    address payable owner;
    
    constructor () {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract Producer is Ownable{
    
    string name;
    uint16 reputation;
    string expertiseCategory;
    
}

contract Manager is Producer {
    
}

contract Product is Ownable {
    string description;
    uint DEVcost;
    uint REVreward;
    Manager manager;
}