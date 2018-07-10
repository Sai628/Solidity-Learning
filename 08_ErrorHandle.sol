pragma solidity ^0.4.16;

contract Sharer {
    function sendHalf(address addr) public payable returns (uint balance) {
        require(msg.value % 2 == 0);  // 仅允许偶数
        uint balanceBeforeTransfer = address(this).balance;
        addr.transfer(msg.value / 2);  // 如果失败，会抛出异常，下面的代码就不会执行
        assert(address(this).balance == balanceBeforeTransfer - msg.value / 2);
        return address(this).balance;
    }
}
