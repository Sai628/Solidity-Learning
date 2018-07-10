pragma solidity ^0.4.16;

contract Selector {
    function f() public pure returns (bytes4) {
        return this.f.selector;
    }
}

library ArrayUtils {
    function map(uint[] memory self, function (uint) pure returns (uint) f) 
    internal
    pure
    returns (uint[] memory r) {
        r = new uint[](self.length);
        for (uint i = 0; i < self.length; i++) {
            r[i] = f(self[i]);
        }
    }
    
    function reduce(uint[] memory self, function (uint, uint) pure returns (uint) f)
    internal
    pure
    returns (uint r) {
        r = self[0];
        for (uint i = 1; i < self.length; i++) {
            r = f(r, self[i]);
        }
    }
    
    function range(uint length) internal pure returns (uint[] memory r) {
        r = new uint[](length);
        for (uint i = 0; i < length; i++) {
            r[i] = i;
        }
    }
}

contract Pyramid {
    using ArrayUtils for *;
    
    function pyramid(uint l) public pure returns (uint) {
        return ArrayUtils.range(l).map(square).reduce(sum);
    }
    
    function square(uint x) internal pure returns (uint) {
        return x * x;
    }
    
    function sum(uint x, uint y) internal pure returns (uint) {
        return x + y;
    }
}

contract Oracle {
    struct Request {
        bytes data;
        function(bytes memory) external callback;
    }
    
    Request[] requests;
    event NewRequest(uint);
    
    function query(bytes data, function(bytes memory) external callback) public {
        requests.push(Request(data, callback));
        emit NewRequest(requests.length - 1);
    }
    
    function reply(uint requestID, bytes response) public {
        // Here goes the check that the reply comes from a trusted source
        requests[requestID].callback(response);
    }
}

contract OracleUser {
    Oracle constant oracle = Oracle(0x1234567);  // known contract
    
    function buySomething() public {
        oracle.query("USD", this.oracleResponse);
    }
    
    function oracleResponse(bytes response) public {
        require(msg.sender == address(oracle));
        // Use the data
    }
}
