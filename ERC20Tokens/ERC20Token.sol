pragma solidity >=0.4.0 < 0.7.0;
contract ERC20Token{


    string rName;
    string rSymbol;
    uint8 dec;
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowances;

    constructor(string memory _name,string memory _symbol,uint8 _decimals, uint _initialSupply) public{
        rName = _name;
        rSymbol = _symbol;
        dec = _decimals;
        balances[msg.sender] = _initialSupply;

    }

    function balanceOf(address _owner) public view returns (uint){
        return balances[_owner];
    }

    function transferTo(address _to, uint _value) public{
        transferFrom(msg.sender, _to, _value);
    }
    function transferFrom(address _from,address _to, uint _value) private{
        require(balances[_from] > _value, "Insufficient Tokens");
         balances[_from] -= _value;
         balances[_to] += _value;
         approve(_to, balances[_to]);
         emit info(msg.sender, _to,balances[_to], allowance(_from,_to));
         require(allowance(_from,_to) >= _value,"Cant send extra funds");
    }

    function approve(address _spender, uint _value) private{
        allowances[msg.sender][_spender] = _value;
        //return allowances[msg.sender][_spender] ;
    }

    function allowance(address _owner,address _spender) public view returns (uint){
        return allowances[_owner][_spender];

    }
    event info(address sender, address to, uint value,uint allow);
}