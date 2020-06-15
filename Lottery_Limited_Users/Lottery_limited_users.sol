pragma solidity >=0.4.21 <0.7.0;

contract Lottery{
     uint waitingStartBlocknum;
     uint registeredCount;
     uint registrationLimit;
     address payable[] users;
     uint256 public constant WAIT_BLOCKS_LIMIT = 3 ;
     uint256 constant REGISTERING_PARTICIPANTS = 1;
     uint256 constant REGISTERING_FINISHED = 2;
     uint256 constant WAITING_FOR_RANDOMNESS = 3;
     uint256 constant SOLVING_LOTERRY = 4;
     uint256 constant LOTTERY_SOLVED = 5;
     mapping(address => bool) public participated;
     bool public lotterySolved;

    constructor(uint _limit) public{
        waitingStartBlocknum = 0;
        registeredCount = 0;
        registrationLimit = _limit;
    }
// Add participant
    function processAddUser(address sender) private {
//Checks : Participant must send > 0.001 ether, 1 address can participate once, 
//         number of participants must not exceed limit
        require(msg.value == 1, "Must send 0.001 ether");
        require(participated[sender] = false, "One address can participate only once");
        require(registeredCount < registrationLimit, "Fixed number of partcipants allowed");
//set true if new participant
        participated[sender] = true;
//Keep record of participants
        users.push(msg.sender);
//Keep count of no. of participants since limited users are allowed
        registeredCount += 1;
        emit userRegistered(sender);
    }

    function details() public payable{
        if(getStage(block.number) == REGISTERING_PARTICIPANTS){
            processAddUser(msg.sender);
        }else{
            if(getStage(block.number) == REGISTERING_FINISHED){
                require(msg.value == 0, "No additional stake allowed");
                waitingStartBlocknum = block.number;
                emit closingList(waitingStartBlocknum);
            }else{
                if(getStage(block.number) == WAITING_FOR_RANDOMNESS){
                    require(msg.value == 0, "No additional stake allowed");
                    revert("Too little time has passed, wait atleast for WAIT_BLOCK_LIMIT");
                }else{
                    if(getStage(block.number) == SOLVING_LOTERRY){
                    require(msg.value == 0, "No additional stake allowed");
                    processSolvingLottery(block.number);

                    }
                }

            }
        }

    }

    function processSolvingLottery(uint blockNum) private{
        uint luckyNumber = uint(blockhash(waitingStartBlocknum + WAIT_BLOCKS_LIMIT));
        luckyNumber = luckyNumber % registrationLimit;
        users[luckyNumber].transfer(address(this).balance);
        emit rewardBlockNum(users[luckyNumber], blockNum);
        lotterySolved = true;
    }

    function getStage(uint blockNum) private returns (uint){
        if(registeredCount < registrationLimit){
            return REGISTERING_PARTICIPANTS;
        }else{
            if (waitingStartBlocknum == 0 || blockNum-waitingStartBlocknum > 256){
                return REGISTERING_FINISHED;
            }else{
            if (blockNum-waitingStartBlocknum < WAIT_BLOCKS_LIMIT){
                return WAITING_FOR_RANDOMNESS;
            }else{
                if(lotterySolved = true){
                return LOTTERY_SOLVED;
                }else{
                return SOLVING_LOTERRY;
                }
            }
            }
        }
    }

        event userRegistered(address sender_adr);
        event closingList(uint blockNum);
        event rewardBlockNum(address winner, uint blocknum);
}