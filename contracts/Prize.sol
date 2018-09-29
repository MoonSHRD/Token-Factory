pragma solidity ^0.4.24;

/*
    This is contract **Кубышка**, which works like a standart кубышка.

    Author can deploy this contract if he want to distribute prizes.
    givePrize will add money to this contract
    getPrize will calculate share and give money to the subscriber, and author
    will get his tokens back.

    So it's can be used in cashback or buyback mechanics

*/

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
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
    uint multiplex = SafeMath.div(_value,tokenshare);
    token.transferFrom(msg.sender,owner,_value);
    require(multiplex >= 1);
    uint moneyshare = SafeMath.div(bounty,100);
    uint cashout = SafeMath.mul(moneyshare,multiplex);
    address reciver = msg.sender;
  //  require(reciver.call.value(cashout));
    reciver.transfer(cashout);

  }

}
