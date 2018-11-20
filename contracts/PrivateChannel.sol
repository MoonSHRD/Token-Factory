pragma solidity ^0.4.24;

import "./Community.sol";
import "./DealAceptor.sol";

contract PrivateChannel is Community, DealAceptor {


    function beforeJoin() internal {


    }

    function afterJoin() internal {}

    function beforeLeave() internal {}

    function afterLeave() internal {}

}

