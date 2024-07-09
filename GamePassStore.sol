// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract store{
    address owner;
    string public  itemName = "Game Pass";
    mapping (address=>uint)  orderId;
    mapping (uint=>uint) public amount;

    constructor (){
        owner = msg.sender;
    }

    function random() view internal returns (uint){
        return uint(keccak256(abi.encode(block.timestamp)))%10000;
    }

    function order()public payable returns(string memory){
        require(orderId[msg.sender]==0,"you have already ordered");
        require(msg.value>=100,"please send more than 100 wei");
        orderId[msg.sender] = random();
        amount[orderId[msg.sender]]=msg.value;
        return "order received";
    }

    function OrderID(address _address) public view returns (uint){
        if(orderId[_address]==0){
            revert("you have not ordered");
        }
        return orderId[_address];
    }

    function cancelOrder() public {
        require(orderId[msg.sender]!=0,"you have not ordered");
        if(amount[orderId[msg.sender]]==0){
            revert("Your amount is zero");
        }
        payable(msg.sender).transfer(amount[orderId[msg.sender]]);
        amount[orderId[msg.sender]] = 0;
        orderId[msg.sender]=0;

        assert(amount[orderId[msg.sender]] == 0);
        assert(orderId[msg.sender]==0);
    }
}