pragma solidity >=0.4.21 <0.7.0;

contract Balance_checker{
    address owner;
    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can do this!");
        _;
    }

    
}