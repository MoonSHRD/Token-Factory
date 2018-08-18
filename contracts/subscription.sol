/* Contract of basic subscription

  NOTE that thic contract require 1 whole token (with 18 decimals) to subscribe
  this mechanics possible will break if token has not 18 decimals.
  probably we need to set multiplex = token decimals or we need to set 18 _decimals
  as a standard token decimals

  advertisment is selling for tokens, price is setting up by owner of Subscription
  it will give us ability to separate price for subscription and price for advertisment
  inside channel, so user can buy subscription for 0.01$ but by advertisment for 100$ for example

  NOTE also that for now it is only basic functionality for buing advertisment
  in the future I suppose we need to improve this, to give owner ability to accept OR
  reject incoming ads proposals before accepting payments

*/

pragma solidity ^0.4.24;

import "./Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Subscription is Ownable {

  Token token;
  mapping (address => uint) public users;
  address crowdsale;
  uint ad_price; // price for commercials
  uint8 public decimals;

  event signedUp(address who);
  event signedOut(address who);
  event banned(address who);
  event adPaid(address who, bytes hashmsg);

  constructor(address _token, address _owner, address _crowdsale) public {

    token = Token(_token);
    owner = _owner;
    crowdsale = _crowdsale;

    decimals = token.decimals();
// uint8 dec = token.decimals;
  //  decimals = dec;

  }

/*
  function askDecimals() public returns (uint8){
  uint8 result = token.decimals;
    return result;

  }
  */



  function signUp() public{

    uint am = 1 * 1 ether;
    token.transferFrom(msg.sender,this,am);
    users[msg.sender]=am;
    emit signedUp(msg.sender);
  }

  function signOut() public{
    uint am = 1 * 1 ether;
    token.transfer(msg.sender,am);
    users[msg.sender]=0;
    emit signedOut(msg.sender);
  }

  function banUser(address _user) public onlyOwner {

    uint am = 1 * 1 ether;
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
