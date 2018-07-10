pragma solidity ^0.4.16;

contract testEtherUnits {
    function tf() public pure returns (bool) {
        if (1 ether == 1000 finney) {
            return true;
        }
        return false;
    }
    
    function ts() public pure returns (bool) {
        if (1 ether == 1000000 szabo) {
            return true;
        }
        return false;
    }
    
    function tw() public pure returns (bool) {
        if (1 ether == 1000000000000000000 wei) {
            return true;
        }
        return false;
    }
}

contract testTimeUnits {
    function currentTimeInSeconds() public view returns (uint) {
        return now;
    }
    
    function f(uint start, uint daysAfter) public view {
        if (now >= start + daysAfter * 1 days) {
            // ...
        }
    }
}
