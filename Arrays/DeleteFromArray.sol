pragma solidity >= 0.4.0 < 0.7.0;

contract deleteFromArray{
        uint[] public values;

        function removeByValue(uint value) public{
            uint i = find(value);
            removeByPosition(i);
        }

        function find(uint value) private view returns (uint){ 
            uint i = 0;
            while(values[i] != value ){
                i++;
            }
            return i;
        }

        function removeByPosition(uint position) private{
            uint i = position;
            while(i < values.length-1){
                values[i] = values[i+1];
                i++;
            }
            //rather than making the last element 0, remove it from array count itself
            values[values.length-1] = 0;
        }

        function addValues(uint newValue) public{
            if (values[values.length-1] == 0 )
            {
              values[values.length-1] = newValue; 
             }
            else{
                values.push(newValue);
            }
              emit val(values, newValue);
        }

        function test() public returns (uint[] memory){
            values.push(10);
            values.push(20);
            values.push(30);
            values.push(40);
            values.push(50);
            uint newValue = 60;
            removeByValue(30);
            addValues(newValue);
            return values;
        }
        
        event val(uint[] valInArray, uint newVal);
}