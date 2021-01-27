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
    mapping(address => Product[]) products;
    mapping(address => uint) noProductsOwned;
    mapping(address => Producer) marketplaceActors;
    
    constructor() public {
        id= "The Marketplace";
    }
    
    struct Product {
        string id;
        string description;
        uint DEVcost;
        uint REVreward;
        address owner;
        bool purchased;
    }
    
    event ProductCreation (
        string id,
        string description,
        uint DEVcost,
        uint REVreward,
        address owner,
        bool purchased,
        uint productNumber
    );
    
    function AddProduct(address owner, Product memory product) private 
    {
        Product memory productToAdd;
        productToAdd.id = product.id;
        productToAdd.description = product.description;
        productToAdd.DEVcost = product.DEVcost;
        productToAdd.REVreward = product.REVreward;
        productToAdd.owner = owner;
        productToAdd.purchased = product.purchased;
        
        products[owner].push(productToAdd);
        noProductsOwned[owner]++;
    }
    
    
    function CreateProduct(string memory _name,string memory _description, uint dev, uint rev) public 
    {
        require(bytes(_name).length > 0);
        require(rev>=dev);
        
        Product memory toCreateProduct = Product(_name,_description,dev,rev,msg.sender,false);
        AddProduct(msg.sender,toCreateProduct);
        uint noProducts = noProductsOwned[msg.sender];
        
        emit ProductCreation(_name, _description, dev, rev, msg.sender, false, noProducts);
    }
}