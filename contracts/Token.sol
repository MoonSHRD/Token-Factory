pragma solidity ^0.4.24;
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Token is StandardToken, Ownable {
    string public name;
    string public symbol;
    uint8 public decimals = 3;
    address public Factory;
    // prepare URANUS
    // probably need to reafactor it to a modifier
    bool public prepared = false;

    constructor(string _name,
    string _symbol,

    uint _INITIAL_SUPPLY,
    address _owner) public {
        name = _name;
        symbol = _symbol;

        totalSupply_ = _INITIAL_SUPPLY;
        Factory = msg.sender;
        owner = _owner;
        //balances go to the owner normally
        // Keep closed if we want to transfer tokens to the crowdsale
      //  balances[owner] = totalSupply_;

    }

   function prepareCrowdsale(address _crowdsale) public{
     require(prepared == false);
     balances[_crowdsale] = totalSupply_;
     prepared = true;


   }





}
