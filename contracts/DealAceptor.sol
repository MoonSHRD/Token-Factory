pragma solidity ^0.4.0;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./IterableMap.sol";
import "./Membership.sol";


contract DealAceptor is Ownable {
    IterableMap registry;

    function work() public onlyOwner {

        if (registry = address(0)) {
            registry = new IterableMap();
        }
    }

    function suggest(Deal deal) public  {
        registry.add(deal);
    }


}
