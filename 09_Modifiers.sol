pragma solidity ^0.4.16;

contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    // 定义了一个函数修改器，可被继承;
    // 修饰时，函数体被插入到 “_;” 处;
    // 不符合条件时，将抛出异常.
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract mortal is owned {
    //  使用继承的`onlyOwner` 
    function close() public onlyOwner {
        selfdestruct(owner);
    }
}

contract priced {
    // 函数修改器可接收参数
    modifier costs(uint price) {
        if (msg.value >= price) {
            _;
        }
    }
}

contract Register is priced, owned {
    uint price;
    mapping (address => bool) registeredAddresses;
    
    constructor(uint initialPrice) public {
        price = initialPrice;
    }
    
    function register() public payable costs(price) {
        registeredAddresses[msg.sender] = true;
    }
    
    function changePrice(uint _price) public onlyOwner {
        price = _price;
    }
}

contract Mutex {
    bool locked;
    
    modifier noReentrancy() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }
    
    // 防止递归调用
    // return 7 之后，locked = false 依然会执行
    function f() public noReentrancy returns (uint) {
        require(msg.sender.call());
        return 7;
    }
}

contract modifySample {
    uint a = 10;
    
    modifier mf1(uint b) {
        uint c = b;
        _;
        c = a;
        a = 11;
    }
    
    modifier mf2() {
        uint c = a;
        _;
    }
    
    modifier mf3() {
        a = 12;
        return;
        _;
        a = 13;
    }
    
    /* 经过modifier后, 函数的执行流程以下:
    uint c = b;
        uint c = a;
            a = 12;
            return ;
            _;
            a = 13;
    c = a;
    a = 11;
    注意到最内层在 `_;` 前return了. 这里test1()中的 `a = 1` 语句是没有执行到的.
    */
    function test1() public mf1(a) mf2 mf3 {
        a = 1;
    }
    
    // 执行test1()后, 再调用test2()将返回11
    function test2() public constant returns (uint) {
        return a;
    }
}
