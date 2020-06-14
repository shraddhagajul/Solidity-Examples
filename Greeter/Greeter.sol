pragma solidity >=0.4.21 <0.7.0;

contract Greeter{
    address owner;
    string greetings;

//used to fetch initial greetings
    constructor(string memory _greetings) public{
        owner = msg.sender;
        greetings = _greetings;
    }
//setGreetings can only be executed by the owner of the contract
    modifier onlyOwner{
        require(msg.sender == owner,"Only owner can do this!");
        _;
    }

    function getGreetings() public view returns (string memory) {
        return greetings;
    }
//_newgreetings will only be set if the owner of contract executes it.
    function setGreetings(string memory _newgreetings) public onlyOwner {
        greetings = _newgreetings;
    }
}
