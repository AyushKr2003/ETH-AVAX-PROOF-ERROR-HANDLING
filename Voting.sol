//SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.26;

contract voting {   

    struct proposal{
        uint id;
        string name;
        string desc;
        uint vote;
        bool finalized;
    }

    address owner;
    uint private proposalCount = 1;
    uint public totalVoters = 0;

    mapping (uint => proposal) public proposals;
    mapping (address => bool) public voter;
    mapping (address => uint) public voteFor;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Only owner can call this function");
        _;
    }

    function createProposal(string memory _name, string memory _des) public onlyOwner {
        proposals[proposalCount] = proposal(proposalCount, _name, _des,0,false);

        proposalCount++;
    }

    function vote(uint _proposalID) public {
        require(voter[msg.sender] == false,"You Have voted");
        require(proposals[_proposalID].finalized == false, "Proposal is already finalized");

        voter[msg.sender] = true;
        voteFor[msg.sender] = _proposalID;
        proposals[_proposalID].vote++;
        totalVoters++;
    }

    function finalizeProposal(uint256 _proposalID) public onlyOwner {
        require(proposals[_proposalID].finalized == false, "Proposal is already finalized");
        require(_proposalID < proposalCount, "Invalid proposal Id");

        if(proposals[_proposalID].vote == 0){
            revert("No vote has been cast to this proposal");
        }

        proposals[_proposalID].finalized = true;

        assert( proposals[_proposalID].finalized == true);
    }

    function totalProposal() public view returns (uint) {
        return proposalCount-1;
    }
}