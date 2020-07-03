pragma solidity >= 0.4.0 < 0.7.0;

contract MultiplyLotteryWinners{
    address owner;
    uint totalParticipants;
    address[] winners;
    uint randNonce = 0;
    uint prize;

    enum LotteryState {Accepting , Finished} LotteryState state;
// Multiple users can select the same lucky number  ==== >> Winner. 
//This conccept can be used for bidding with some modifications.
    mapping(uint => address[]) choices;
    mapping(address => bool) gotReward;

    modifier onlyOwner{
        require(owner == msg.sender, "Only owner can issue this");
        _;
    }
    constructor() public {
        owner = msg.sender;
        state = LotteryState.Accepting;
        totalParticipants = 0;
    }

    function addMembers(uint _choosenNumber) public payable{
        require(_choosenNumber > 0 && _choosenNumber < 100, "Number must be in 100");
        require(msg.value == 0.1 ether, "Transfer 0.1 ether to join");
        require(state == LotteryState.Accepting, "Lottery is Finsihed");
        choices[_choosenNumber].push(msg.sender);
        totalParticipants += 1;
    }

    function selectWinner() public payable onlyOwner{
        state = LotteryState.Finished;
        uint luckyNumber = random() + 1;
        winners = choices[luckyNumber];
        prize = address(this).balance / winners.length;
    }


    function withdrawal() public payable{
        require(isWinner(), "You are not the winner");
        require(gotReward[msg.sender] != true, "You have got your reward");
        msg.sender.transfer(prize);
    }

    function isWinner() private view returns (bool) {
        for(uint i = 0; i < winners.length; i++) {
            if(winners[i] == msg.sender){
                return true;
            }
            else{
                return false;
            }
        }
    }

    function random() private returns (uint){
        uint rand = uint(keccak256(abi.encodePacked(block.number,msg.sender,randNonce)))% totalParticipants;
        randNonce++;
        return rand;
    }





}