pragma solidity >= 0.4.0 < 0.7.0;
import "zeppelin/contracts/token/StandardToken.sol";
contract PiotrexToken is StandardToken{
    string public constant name = "PiotrexToken";
    string public constant symbol = "PTX";
    uint8 public constant decimals = 18;
    mapping(address => uint) public balances;

    uint initialSupply = 1000*(10 ** uint(decimals));
    uint totalSupply;

    constructor(){
        balances[msg.sender] = initialSupply;
        totalSupply = initialSupply;

    }

}