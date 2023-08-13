// SPDX-License-Identifier: GPL-3.0
pragma solidity ^ 0.8.21;
contract ballot{
    address public judge;
    struct voter{
        bool rightToVote;
        bool voted;
    }
    struct candidate{
        string candidateName;
        uint voteCount;
    }
    candidate [2] candidates;
    uint candidateId=2;
    // function pushCandidate(string memory candidateName)public {
    //     require(msg.sender==judge,"Only Judge has right to push candidates");
    //     candidates[candidateId]=candidate(candidateName,0);
    //     candidateId++;
    // }
    mapping(address => voter)mpp;
    constructor()
    {
        judge=msg.sender;
        candidates[0]=candidate("Raam",0);
        candidates[1]=candidate("Shyaam",0);
    }
    function rightToVote(address _voter)  public{
        require(msg.sender == judge,"You are not allowed to give right To vote");
        voter memory voterObject=mpp[_voter];
        require(!voterObject.rightToVote,"already given right to vote");
        require(!voterObject.voted,"already voted");
        voterObject.rightToVote=true;
        mpp[_voter]=voterObject;
    }
    function vote(uint _candidateId) public{
        address voterAdress=msg.sender;
        voter memory voterObject=mpp[voterAdress];
        require(voterObject.rightToVote,"No right to vote");
        require(!voterObject.voted,"already Voted");
        candidate memory candidateObj=candidates[_candidateId];
        candidateObj.voteCount+=1;
        voterObject.voted=true;
        mpp[voterAdress]=voterObject;
        candidates[_candidateId]=candidateObj;
    }
    function getResult()public view returns(string memory )
    {
        uint maxCount=0;
        string memory winner ;
        for(uint i=0;i<candidateId;i++)
        {
            if(candidates[i].voteCount>maxCount)
            {
                maxCount=candidates[i].voteCount;
                winner = candidates[i].candidateName;
            }
        }
        return winner;
    }
}
