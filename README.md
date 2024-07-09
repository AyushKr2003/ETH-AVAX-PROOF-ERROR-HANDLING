# Store Smart Contract

## Overview

The `store` smart contract is a simple Ethereum-based contract that allows users to place orders for an item called "Game Pass". Users can place an order by sending a specified amount of Ether (minimum 100 wei). Each order is assigned a unique ID, and users can also cancel their orders and get a refund.

## Features

- **Order Placement**: Users can place an order by sending Ether. Each order is assigned a unique ID.
- **Order Cancellation**: Users can cancel their order and get a refund of the amount they sent.
- **Order Tracking**: Users can check the order ID associated with their address.

## Contract Details

### Variables
***
- `address owner`: The owner of the contract (the deployer).
- `string public itemName`: The name of the item, which is "Game Pass".
- `mapping (address => uint) orderId`: A mapping to store the order ID associated with each address.
- `mapping (uint => uint) public amount`: A mapping to store the amount sent with each order ID.

### Constructor
***
The constructor sets the owner of the contract to the address that deploys the contract.

```solidity
constructor (){
    owner = msg.sender;
}
```

## Functions

### **random**
An internal function that generates a random number based on the current block timestamp.

```solidity
function random() view internal returns (uint){
    return uint(keccak256(abi.encode(block.timestamp)))%10000;
}
```
### order
A payable function that allows users to place an order. It requires a minimum of 100 wei and ensures that the user has not already placed an order.

```solidity
function order() public payable returns (string memory) {
    require(orderId[msg.sender] == 0, "you have already ordered");
    require(msg.value >= 100, "please send more than 100 wei");
    orderId[msg.sender] = random();
    amount[orderId[msg.sender]] = msg.value;
    return "order received";
}
```
### OrderID
A public view function that returns the order ID associated with a given address. It reverts if the address has not placed an order.

```solidity
function OrderID(address _address) public view returns (uint) {
    if (orderId[_address] == 0) {
        revert("you have not ordered");
    }
    return orderId[_address];
}
```
### cancelOrder
A public function that allows users to cancel their order and get a refund. It ensures that the user has placed an order and that the amount is non-zero before proceeding with the refund.

```solidity
function cancelOrder() public {
    require(orderId[msg.sender] != 0, "you have not ordered");
    if (amount[orderId[msg.sender]] == 0) {
        revert("Your amount is zero");
    }
    payable(msg.sender).transfer(amount[orderId[msg.sender]]);
    amount[orderId[msg.sender]] = 0;
    orderId[msg.sender] = 0;

    assert(amount[orderId[msg.sender]] == 0);
    assert(orderId[msg.sender] == 0);
}
```
## Usage
### Deploying the Contract
 - Deploy the contract using an Ethereum-compatible development environment such as Remix, Truffle, or Hardhat.
 - Once deployed, the deployer address will be set as the owner of the contract.
### Placing an Order
To place an order, call the `order` function and send at least 100 wei along with the transaction. If successful, the function will return "order received" and assign a unique order ID to your address.

### Checking Order ID
To check the order ID associated with your address, call the `OrderID` function with your address as the parameter. If you have placed an order, it will return the order ID; otherwise, it will revert with "you have not ordered".

### Cancelling an Order
To cancel your order and receive a refund, call the `cancelOrder` function. The function will transfer the amount back to your address and reset your order ID and amount to zero.

## License
This project is licensed under the MIT License. See the LICENSE file for details.