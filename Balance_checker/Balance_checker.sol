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

//Address of Contract
    function getAddressOfContract() public view returns (address){
        return address(this);
    }
//Address of Owner
    function getAddressOfOwner() public view returns (address){
        return owner;
    }
//Address of Sender
    function getAddressOfSender() public view returns (address){
        return msg.sender;
    }
//Balance of contract deployer(owner)
    function getBalanceOfOwner() public view onlyOwner returns (uint) {
            return owner.balance;
    }
// Balance of contract
    function getBalanceOfContract() public view returns (uint){
        return address(this).balance;
    }
// Balance of sender (anyone who tries to execute the contract apart from owner)
    function getBalanceOfSender() public view returns (uint){
        return msg.sender.balance;
    }

}