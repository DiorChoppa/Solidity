// SPDX-License-Identier: MIT

pragma solidity >=0.4.22 <0.6.0;
contract Ballot {
    // СК для голосования со следующими правилами
    // При создании голосовании указываем количество различных вариантов исхода (proposals=10)
    // И каждый участник сети может проголосвать только 1 раз (за любой proposal)

    uint[]  proposals; //положительные целые числа (unsigned int)
    mapping(address => bool) voters;

    // Инициализируем кол-во proposals
    constructor(uint proposalsCount) public {
        proposals.length = proposalsCount;
    }

    // Ф-я голосования
    function vote(uint proposal) public {
        bool hasVoted = voters[msg.sender]; // Проверяем проголосвал ли уже этот адрес
        require(!hasVoted && proposal < proposals.length);
        voters[msg.sender] = true;
        proposals[proposal]++;
    }

    function winningProposal() public view returns (uint _winningProposal) {
        uint winningVoteCount = 0;
        for (uint prop = 0; prop < proposals.length; prop++){
            uint voteCount = proposals[prop];
            if (voteCount > winningVoteCount){
                winningVoteCount = voteCount;
                _winningProposal = prop;
            }
        }
    }
}