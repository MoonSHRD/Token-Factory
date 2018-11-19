pragma solidity ^0.4.24;

import "./Community.sol";

contract PrivateChannel is Community {


    function beforeJoin() internal {
        require(token.balanceOf(msg.sender) > 10 ^ ^ token.decimals - 1)
    }

    function afterJoin() internal {}

    function beforeLeave() internal {}

    function afterLeave() internal {}

}

