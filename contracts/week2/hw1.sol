pragma solidity ^0.8.10;

contract Bank {
    address payable public Owner;
    mapping(address => uint) public User;

    constructor() {
        Owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(payable(msg.sender) == Owner, "not adm");
        _;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public onlyOwner {
        uint amount = address(this).balance;
        (bool success, ) = Owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    receive() external payable {
        User[msg.sender] = msg.value;
    }

}