pragma solidity ^0.4.16;

contract EnumTest {

    enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;
    
    function setGoStraight() public {
        choice = ActionChoices.GoStraight;
    }
    
    function getChoice() public view returns (ActionChoices) {
        return choice;
    }
    
    function getDefaultChoice() public pure returns (uint) {
        return uint(defaultChoice);
    }
}
