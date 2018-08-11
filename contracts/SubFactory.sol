pragma solidity ^0.4.24;

/*
  Factory for deployment new subscription contracts

*/

import "./subscription.sol";


contract SubFactory {
  //  address god;
  //  mapping (address => address[]) public tokens;



  function createSubscription(address _token,address _owner,address _crowdsale) public returns(address){

    address sub = address(new Subscription(_token,_owner,_crowdsale));
    return sub;

  }




}
