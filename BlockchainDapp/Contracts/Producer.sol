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
    
    constructor() public {
        expertiseCategory = "Manager";
    }
}

contract Product is Ownable {
    string description;
    uint DEVcost;
    uint REVreward;
    Manager manager;
}

contract Marketplace {
    string id;
    uint noProducts = 0;
    mapping(string => Product) products;
    mapping(address => Producer) marketplaceActors;
    
    constructor() public {
        id= "The Marketplace";
    }
    
    struct Product {
        string id;
        string description;
        uint DEVcost;
        uint REVreward;
        Manager manager;
        address owner;
        bool purchased;
    }
    
    event ProductCreation (
        //all the parameters
        uint noProducts
    );
    
    function CreateProduct() public
    {
        //require address to be manager;
        noProducts++;
        
        emit ProductCreation(noProducts);
    }
}