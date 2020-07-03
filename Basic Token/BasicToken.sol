pragma solidity >=0.4.0 < 0.7.0;
contract BasicToken{
    uint public initialSupply;
    uint amountSender;
    uint amountRecipient;
    mapping(address => uint) balances;
    constructor(uint _initialSupply) public{
       initialSupply = _initialSupply;
       balances[msg.sender] = _initialSupply;
    }

    function transfer(address _recipient, uint _amount)public{
        require(balances[msg.sender] > _amount, "Not enough funds");
        require(_recipient != msg.sender, "No need to send token to our self");
        require(balances[_recipient] + _amount > balances[_recipient]); //overflow
        balances[msg.sender] -= _amount;
        amountSender = balances[msg.sender];
        balances[_recipient] += _amount;
        amountRecipient = balances[_recipient];
        emit owner(msg.sender,amountSender);
        emit tokenRecipient(_recipient,amountRecipient);
    }

    event owner(address owner,uint balance);
    event tokenRecipient(address tokenRecipient, uint balance);


}