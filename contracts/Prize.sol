pragma solidity ^0.4.24;

/*
    template for crowdsale ovveride

*/

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./Token.sol";

contract Prize is Ownable {

  Token token;
  // sector Priz na barabane
  uint bounty;

  constructor(address _token,address _owner) public {
    token = Token(_token);
    owner = _owner;
  }

  function givePrize() payable public onlyOwner {
    bounty += msg.value;
  }

// bounty hanter.. BOUNTY HANTER!
  function getPrize(uint _value) public {
    uint sup = token.totalSupply();
    uint tokenshare = SafeMath.div(sup,100);
    uint multiplex = SafeMath.div(tokenshare,_value);
    token.transferFrom(msg.sender,owner,_value);
    require(tokenshare >= 1);
    uint moneyshare = SafeMath.div(bounty,100);
    uint cashout = SafeMath.mul(moneyshare,multiplex);
    address reciver = msg.sender;
  //  require(reciver.call.value(cashout));
    reciver.transfer(cashout);

  }

}
