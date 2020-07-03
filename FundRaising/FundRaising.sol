pragma solidity >= 0.4.0 < 0.7.0;
pragma experimental ABIEncoderV2;

contract fundRaising{

    address payable owner;
    uint goal;
    uint timeLimit;
    uint amountCollected = 0;
    struct Investors{
        address investor_address;
        uint invested_amount;
    }
    Investors public investorInfo;
    



    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can take funds");
        _;
    }

    constructor(uint _goal, uint _timeLimit) public{
        owner = msg.sender;
        goal = _goal;
        timeLimit = _timeLimit;
    }

    function getFunds() public payable{
        require(amountCollected <= goal,"Fund Raising Completed!");
        require(msg.value > 0.01 ether, "Please donate suffiient funds(minimum : 0.01 ether)");
        require(block.timestamp < timeLimit, "Fund Raising Completed!");
        amountCollected += msg.value;
        Investors memory info = investorInfo;
        info.investor_address = msg.sender;
        info.invested_amount = msg.value;
        emit investorDetails(investorInfo);


    }

    function withdrawalOwner() public payable onlyOwner{
        require(block.timestamp > timeLimit, "Fund Raising Completed!");
        owner.transfer(address(this).balance);
        emit amount(address(this).balance);
    }

    event amount(uint amountInAccount);
    event investorDetails(Investors investerInfo);

}