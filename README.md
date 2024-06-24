# VotingContract

## Overview

The `VotingContract` is a smart contract written in Solidity that facilitates the creation and management of proposals and voting on those proposals. It allows an owner to create proposals, while users can vote on these proposals. The contract includes functionality to finalize proposals and various utility functions to interact with the contract.

## Features

- Create new proposals.
- Vote on existing proposals.
- Finalize proposals.
- Check the total number of proposals.
- View details of specific proposals.

## Usage

### Functions

#### `createProposal(string memory _name, string memory _desc) public onlyOwner`

Creates a new proposal with the specified name and description.

- **Parameters**: 
  - `_name`: The name of the proposal.
  - `_desc`: The description of the proposal.
  
- **Requirements**:
  - Only the owner can call this function.

#### `vote(uint _proposalID) public`

Casts a vote for the specified proposal.

- **Parameters**: 
  - `_proposalID`: The ID of the proposal to vote for.
  
- **Requirements**:
  - The caller must not have voted before.
  - The proposal must not be finalized.

#### `finalizeProposal(uint _proposalID) public onlyOwner`

Finalizes the specified proposal, preventing further votes.

- **Parameters**: 
  - `_proposalID`: The ID of the proposal to finalize.
  
- **Requirements**:
  - Only the owner can call this function.
  - The proposal must not be finalized.
  - The proposal must exist and have at least one vote.

#### `totalProposals() public view returns (uint)`

Returns the total number of proposals.

- **Returns**: 
  - The total number of proposals (excluding the initial count).

#### `getProposal(uint _proposalID) public view returns (Proposal memory)`

Returns the details of the specified proposal.

- **Parameters**: 
  - `_proposalID`: The ID of the proposal to retrieve.
  
- **Returns**: 
  - The details of the proposal.
  
- **Requirements**:
  - The proposal must exist.


### Modifiers

#### `onlyOwner`

Ensures that the caller is the owner of the contract.

- **Requirements**:
  - The caller must be the owner of the contract.

### Example

Below is an example of how to interact with the `VotingContract`:

```solidity
// Deploy the contract
VotingContract votingContract = new VotingContract();

// Create a proposal (only owner can do this)
votingContract.createProposal("Proposal 1", "Description of proposal 1");

// Cast a vote for proposal ID 1
votingContract.vote(1);

// Check the total number of proposals
uint totalProposals = votingContract.totalProposals(); // Should return 1

// Get details of proposal ID 1
Proposal memory proposal = votingContract.getProposal(1);

// Finalize the proposal (only owner can do this)
votingContract.finalizeProposal(1);

// Multiply two numbers
uint product = votingContract.multiply(3, 4); // Should return 12

// Donate Ether to the contract
votingContract.donate{value: 1 ether}();

```

## License
This project is licensed under the UNLICENSED License.