// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Election {
    address public admin;
    bool public electionActive;

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    
    uint public candidatesCount;

    event VotedEvent(uint indexed candidateId, address indexed voter);
    event CandidateAdded(uint indexed candidateId, string name);
    event ElectionToggled(bool isActive);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    constructor() {
        admin = msg.sender;
        electionActive = false; // Election is closed by default
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    function toggleElection() public onlyAdmin {
        electionActive = !electionActive;
        emit ElectionToggled(electionActive);
    }

    function vote(uint _candidateId) public {
        require(electionActive, "Election is currently closed");
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit VotedEvent(_candidateId, msg.sender);
    }

    function getAllCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory currentCandidates = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            currentCandidates[i - 1] = candidates[i];
        }
        return currentCandidates;
    }
}
