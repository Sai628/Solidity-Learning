pragma solidity ^0.4.16;

contract C {
    uint[] x; // x的存储位置是storage的

    function f(uint[] memoryArray) public {
        x = memoryArray;  // 从memory复制到storage
        uint[] storage y = x;  // storage引用传递局部变量y(y是一个storage引用)
        y[7];
        y.length = 2;  // x同样会被修改
        delete x;  // y同样会被修改

        // 错误, 不能将memory赋值给局部变量
        // y = memoryArray;

        // 错误, 不能通过引用销毁storage
        // delete y;

        g(x);  // 引用传递, g可以改变x的内容
        h(x);  // 拷贝到memory, h无法改变x的内容
    }

    function g(uint[] storage storageArray) internal {}
    function h(uint[] memoryArray) public {}
}
