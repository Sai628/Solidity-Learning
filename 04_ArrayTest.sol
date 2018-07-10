pragma solidity ^0.4.16;

contract C {
    function f1(uint len) public pure {
        uint[] memory a = new uint[](7);
        a[6] = 8;
        //a.length = 100; 错误. memory的变长数组不支持调整数组长度
        
        bytes memory b = new bytes(len);
    }
     
    function f1() public pure {
        // 通过数组常量，创建的数组是memory的，同时还是定长的
        g([uint(1), 2, 3]);
         
        // 定长数组，不能与变长数组相互赋值
        // uint[] memory x = [uint(1), 2, 3];
    }
     
    function g(uint[3] _data) public pure {
         // ...
    }
}

contract ArrayContract {
    uint[2 ** 20] m_aLotOfIntegers;
    // 这里不是两个动态数组的数组，而是一个动态数组里，每个元素是长度为二的数组
    bool[2][] m_pairsOfFlags;
    
    bytes m_byteData;
    
    function setAllFlagPairs(bool[2][] newPairs) public {
        m_pairsOfFlags = newPairs;
    }
    
    function setFlagPair(uint index, bool flagA, bool flagB) public {
        // 访问不存在的index会抛出异常
        m_pairsOfFlags[index][0] = flagA;
        m_pairsOfFlags[index][1] = flagB;
    }
    
    function addFlag(bool[2] flag) public returns (uint) {
        // push 方法会返回值为新的长度
        return m_pairsOfFlags.push(flag);
    }
    
    function changeFlagArraySize(uint newSize) public {
        // 如果新size更小, 移除的元素会被销毁
        m_pairsOfFlags.length = newSize;
    }
    
    function clear() public {
        // 销毁
        delete m_pairsOfFlags;
        delete m_aLotOfIntegers;
        
        // 同销毁一样的效果
        // m_pairsOfFlags.length = 0;
    }
    
    function byteArrays(bytes data) public {
        // byte arrays ("bytes") are different as they are stored without padding,
        // but can be treated identical to "uint8[]"
        m_byteData = data;
        m_byteData.length += 7;
        m_byteData[3] = byte(8);
        delete m_byteData[2];
    }
    
    function createMemoryArray(uint size) public pure returns (bytes) {
        // Dynamic memory arrays are created using `new`:
        uint[2][] memory arrayOfPairs = new uint[2][](size);
        
        // Create a dynamic byte array
        bytes memory b = new bytes(200);
        for (uint i = 0; i < b.length; i++) {
            b[i] = byte(i);
        }
        
        return b;
    }
}
