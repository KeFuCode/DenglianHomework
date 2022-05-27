pragma solidity ^0.8.10;

contract Score {
    mapping(address => uint) public TestScore;
    address public Owner;

    modifier OnlyOwner {
        require(msg.sender == Owner ,"not teacher");
        _;
    }

    modifier ScoreRange(uint _testScore) {
        require(_testScore <= 100 ,"score must <=100");
        _;
    }

    constructor() {
        Owner = msg.sender;
    }

    function ModifyScore(address _stu, uint _testScore) public OnlyOwner ScoreRange(_testScore) {
        TestScore[_stu] = _testScore;
    }

    function changeOwner(address _teacher) public OnlyOwner {
        Owner = _teacher;
    }

}

interface IScore {
    function ModifyScore(address _stu, uint _testScore) external;
}

contract Teacher {
    function modifyStudentScore(address _stu, uint _testScore, address _Score) external {
        IScore(_Score).ModifyScore(_stu, _testScore);
    }
}