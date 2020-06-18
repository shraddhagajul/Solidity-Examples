pragma solidity >= 0.4.0 < 0.7.0;

contract LimitedLottery{
    uint registrationLimit;
    mapping(address => bool) public participants;
    address payable[] users;
    uint registrationcount;
    address owner;
    uint randNonce = 0;

    modifier onlyOwner{
        require(msg.sender == owner, "Only owner can issue lottery");
        _;
    }


constructor(uint _limit) public{
    require(_limit > 1, "Limit should be more than 1");
    registrationcount = 0;
    registrationLimit = _limit;
    owner = msg.sender;
}

function provideNewUser(address _sender) public payable{
    require(msg.value > 1 finney, "Must send 0.001 ether");
    require(participants[_sender] == false, "One address can participate only once");
    require(registrationcount < registrationLimit, "Fixed number of partcipants allowed");
    participants[_sender] = true;
    users.push(msg.sender);
    registrationcount += 1;
    emit userRegistered(_sender);
}

function solveLottery() public payable onlyOwner{
    require(registrationcount > 1, "Wait for more participants");
    address payable winner = users[random()];
    winner.transfer(address(this).balance);
    emit winningAmount(winner);

}

function random() private returns (uint){
    uint rand = uint(keccak256(abi.encodePacked(block.number, msg.sender, randNonce))) % registrationcount;
    randNonce++;
    emit randomWinner(keccak256(abi.encodePacked(block.number, msg.sender, randNonce)), rand);
        return rand;

}

event winningAmount(address payable winner_address);
event randomWinner(bytes32 cal,uint rand_no);
event userRegistered(address user);
}