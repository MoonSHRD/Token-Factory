/*

Antispam idea in such version of subscription where subscriber
adding deposit to the channel and get him back when unsubscribe.

This version is work with 'ether', not tokens.

  NOTE that in Antispam model channel owner do not sell tokens and
  do not earn on his subscribers except advertisment.

*/



pragma solidity ^0.4.24;


import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Antispam is Ownable {

  mapping (address => uint) public users;

  uint public ad_price; // price for commercials
  uint public depo_price; // price for depo
  uint period; // period of minimal subscription


  event signedUp(address who);
  event signedOut(address who);
  event banned(address who);
  event adPaid(address who, bytes hashmsg);

  constructor(address _owner) public {


    owner = _owner;
    depo_price = 0;
  }



  function signUp() public payable{

    uint am = msg.value;
    require(am==depo_price);
    users[msg.sender]=am;
    emit signedUp(msg.sender);
  }

  function signOut() public{
    address user = msg.sender;
    uint am = users[user];
    user.transfer(am);
    users[msg.sender]=0;
    emit signedOut(msg.sender);
  }

  function banUser(address _user) public onlyOwner {

    address user = msg.sender;
    uint am = users[user];
    owner.transfer(am);
    users[_user]=0;
    emit banned(msg.sender);

  }

  // This function set minamal period for the Subscription
  // This is for situation when spammer signIn, spam and then signOut, taking his fund.
  function setPeriod (uint _period) public onlyOwner returns(uint) {
    period = _period;
    return period;

  }

  // This function should be set up in Wei format
  function setDepoPrice (uint _price) public onlyOwner returns(uint) {
    depo_price = _price;
    return depo_price;
  }

  // Set up price for commercials
  // This function should be set up in Unit format and not wei
  function setAdPrice(uint _price) public onlyOwner returns(uint) {
    ad_price = _price;
    return ad_price;

  }


  //buing commercials basic appendix
  function buyAd(bytes _hash) public payable {
    require(ad_price>0);
  //  address user = msg.sender;
    uint am = msg.value;
    owner.transfer(am);
    // emit event that sender has paid for the ad with given hash
    emit adPaid(msg.sender,_hash);
  }



}
