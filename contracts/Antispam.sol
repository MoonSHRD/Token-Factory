/*

Antispam idea in such version of subscription where subscriber
adding deposit to the channel and get him back when unsubscribe.

This version is work with 'ether', not tokens.
*/



pragma solidity ^0.4.24;

import "./Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Antispam is Ownable {

  Token token;
  mapping (address => uint) public users;
  address crowdsale;
  uint public ad_price; // price for commercials
  uint8 public decimals;
  uint public mainUnit;

  event signedUp(address who);
  event signedOut(address who);
  event banned(address who);
  event adPaid(address who, bytes hashmsg);

  constructor(address _token, address _owner, address _crowdsale) public {

    token = Token(_token);
    owner = _owner;
    crowdsale = _crowdsale;

    decimals = token.decimals();
    setUnit();

  }

  function setUnit() internal returns (bool) {
    uint n = decimals - 1;
    mainUnit = 10 ** n;
    return true;
  }


  function signUp() public{

    uint am = 1 * mainUnit;
    token.transferFrom(msg.sender,this,am);
    users[msg.sender]=am;
    emit signedUp(msg.sender);
  }

  function signOut() public{
    uint am = 1 * mainUnit;
    token.transfer(msg.sender,am);
    users[msg.sender]=0;
    emit signedOut(msg.sender);
  }

  function banUser(address _user) public onlyOwner {

    uint am = 1 * mainUnit;
    token.transfer(crowdsale,am);
    users[_user]=0;
    emit banned(msg.sender);

  }

  // Set up price for commercials
  function setAdPrice(uint _price) public onlyOwner returns(uint) {
    ad_price = _price;
    return ad_price;

  }

  //buing commercials basic appendix
  function buyAd(bytes _hash) public {
    require(ad_price>0);
    // запрашиваем перевод токенов владельцу
    require(token.transferFrom(msg.sender,owner,ad_price));
    // emit event that sender has paid for the ad with given hash
    emit adPaid(msg.sender,_hash);
  }

}
