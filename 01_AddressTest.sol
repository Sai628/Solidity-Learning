pragma solidity ^0.4.16;

contract AddressTest {
    
    uint score = 0;
    
    event logdata(bytes data);
    
    function() public payable {
        emit logdata(msg.data);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function setScore(uint s) public {
        score = s;
    }
    
    function getScore() public view returns (uint) {
        return score;
    }
}

contract CallTest {
    
    event logSendEvent(address to, uint value);
    
    function deposit() public payable {
    }
    
    function transferEther(address to) public payable {
        to.transfer(10);
        emit logSendEvent(to, 10);
    }
    
    function callNoFunc(address addr) public returns (bool) {
        return addr.call("hello world", 1234);
    }
    
    function callFunc(address addr) public returns (bool) {
        bytes4 methodId = bytes4(keccak256("setScore(uint256)"));
        return addr.call(methodId, 100);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
